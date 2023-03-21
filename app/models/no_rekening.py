from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()

class Daftar(Base):
    __tablename__ = "daftar"
    id = Column(Integer, primary_key=True, index=True, unique=True, autoincrement=True)
    nama = Column(String)
    nik = Column(String)
    no_hp = Column(String)
    no_rekening = relationship("NoRekening", back_populates="daftar", uselist=False)

        
class NoRekening(Base):
    __tablename__ = "no_rekening"
    id = Column(Integer, primary_key=True, index=True, unique=True, autoincrement=True)
    no_rekening = Column(Integer, unique=True)
    daftar_id = Column(Integer, ForeignKey("daftar.id"), unique=True)
    daftar = relationship("Daftar", back_populates="no_rekening")



