import enum
import datetime
from typing import Optional, Annotated
from sqlalchemy import ForeignKey, Table, Column, Integer, String, MetaData, func, text
from sqlalchemy.orm import Mapped, mapped_column
from database import Base, str_256

# metadata_obj = MetaData() # данные о всех таблицах на стороне приложения



# # объявление в императивном стиле
# workers_table = Table(
#     "workers",
#     metadata_obj,
#     Column("id", Integer, primary_key=True),
#     Column("username", String),
# ) 












intpk = Annotated[int, mapped_column(primary_key=True)]

created_at = Annotated[datetime.datetime, mapped_column(
        server_default=text("TIMEZONE('utc', now())")
        )]

updated_at = Annotated[datetime.datetime, mapped_column(
        server_default=text("TIMEZONE('utc', now())"), 
        onupdate=datetime.timezone.utc
        )]





# объявление в декларативном стиле
class WorkersOrm(Base):
    __tablename__ = "workers"

    # id: Mapped[int] = mapped_column(primary_key=True)
    id: Mapped[intpk]
    username: Mapped[str]                               # можно прям так оставить




class Workload(enum.Enum):
    parttime = "parttime"
    fulltime = "fulltime"

class ResumesOrm(Base):
    __tablename__ = "resumes"

    id: Mapped[intpk]

    # title: Mapped[str] = mapped_column(String(256))
    title: Mapped[str_256] # сами создали этот тип данных

    # compensation: Mapped[int] = mapped_column(nullable=True)
    # compensation: Mapped[Optional[int]]
    compensation: Mapped[int | None]

    workload: Mapped[Workload]

    # worker_id: Mapped[int] = mapped_column(ForeignKey(WorkersOrm.id)) - так не надо, но можно
    worker_id: Mapped[int] = mapped_column(ForeignKey("workers.id", ondelete="CASCADE")) # SET NULL, но тогда надо Optional[int]

    # created_at: Mapped[datetime.datetime] = mapped_column(server_default=func.now())
    # created_at: Mapped[datetime.datetime] = mapped_column(
    #   default=datetime.timezone.utc
    #   ) # - на стороне нашего приложения дата формируется

    # created_at: Mapped[datetime.datetime] = mapped_column(
    #     server_default=text("TIMEZONE('utc', now())")
    #     ) # - на стороне бд дата формируется
    

    # updated_at: Mapped[datetime.datetime] = mapped_column(
    #     server_default=text("TIMEZONE('utc', now())"), 
    #     onupdate=datetime.timezone.utc
    #     )


    created_at: Mapped[created_at]
    updated_at: Mapped[updated_at]
