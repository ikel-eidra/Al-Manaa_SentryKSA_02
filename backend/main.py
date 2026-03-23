from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime, timedelta
import random

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
    Returns the latest raw intelligence scraped from X, Telegram, and Official Channels.
    (Currently returns simulated data pending actual scraper integration)
    """
    now = datetime.utcnow()
    return [
        {
            "id": "1",
            "source": "X / @CENTCOM",
            "report": "Statement: Elevated ballistic missile activity detected in western Iran.",
            "timestamp": (now - timedelta(minutes=15)).isoformat(),
            "confidence": 0.92
        },
        {
            "id": "2",
            "source": "Telegram / IDF Official",
            "report": "Video Statement: Increased drone swarm preparations observed near border regions.",
            "timestamp": (now - timedelta(minutes=45)).isoformat(),
            "confidence": 0.88
        },
        {
            "id": "3",
            "source": "Instagram / IRNA_News",
            "report": "Infographic: State media announces upcoming military exercises in the Persian Gulf.",
            "timestamp": (now - timedelta(hours=2)).isoformat(),
            "confidence": 0.99
        }
    ]

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
