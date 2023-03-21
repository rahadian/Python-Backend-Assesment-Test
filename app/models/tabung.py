import pytz
from sqlalchemy import Column, Integer, String, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime
from .no_rekening import NoRekening

tz = pytz.timezone('Asia/Jakarta')
Base = declarative_base()

class NoRekening(Base):
    __tablename__ = "no_rekening"
    id = Column(Integer, primary_key=True, index=True, unique=True, autoincrement=True)
    no_rekening = Column(String, unique=True)
    daftar_id = Column(Integer, ForeignKey("daftar.id"), unique=True)
    # daftar = relationship("Daftar", back_populates="no_rekening")

class Tabung(Base):
    __tablename__ = "tabung"
    id = Column(Integer, primary_key=True, index=True, unique=True, autoincrement=True)
    no_rekening = Column(Integer, ForeignKey("no_rekening.no_rekening"), unique=True)
    nominal = Column(String, nullable=True)
    status = Column(String, nullable=True)
    waktu = Column(DateTime, default=datetime.now(tz))

