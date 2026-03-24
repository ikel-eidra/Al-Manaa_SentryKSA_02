from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime, timedelta
import random

from scrapers.news_scraper import GlobalNewsScraper
from scrapers.telegram_scraper import TelegramOSINTScraper

app = FastAPI(
    title="SentryKSA Intelligence Brain",
    description="Backend microservice for OSINT scraping and threat intelligence correlation.",
    version="1.0.0",
)

# Allow Flutter app to connect
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"status": "SentryKSA Intelligence Brain is online."}

@app.get("/api/v1/intelligence/stream")
def get_osint_stream():
    """
    Aggregates intelligence from the active OSINT scrapers (News RSS & Telegram).
    """
    try:
        # Initialize scrapers
        news_scraper = GlobalNewsScraper()
        telegram_scraper = TelegramOSINTScraper()

        # Fetch data
        news_data = news_scraper.fetch_latest_intel()
        telegram_data = telegram_scraper.fetch_recent_messages()

        # Combine, sort by timestamp (newest first), and return
        combined_stream = news_data + telegram_data

        # Sort descending by timestamp string
        combined_stream.sort(key=lambda x: x['timestamp'], reverse=True)

        return combined_stream

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to scrape OSINT sources: {str(e)}")

@app.get("/api/v1/threats/active")
def get_active_threats():
    """
    Returns the correlated, high-confidence threat currently triggering the War Room countdown.
    """
    now = datetime.utcnow()
    # Simulating a threat impacting in exactly 2 hours and 44 minutes
    impact_time = now + timedelta(hours=2, minutes=44, seconds=12)

    return {
        "isActive": True,
        "threatType": "BALLISTIC (IRGC)",
        "targetCorridor": "Eastern Province / Oil Loop",
        "impactTime": impact_time.isoformat(),
        "severity": "CRITICAL"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
