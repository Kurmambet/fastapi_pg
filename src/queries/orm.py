from sqlalchemy import text, insert
from database import sync_engine, async_engine, session_factory, async_session_factory, Base
from models import WorkersOrm


# def create_tables():
#     metadata_obj.drop_all(sync_engine)     # from models import metadata_obj
#     sync_engine.echo = False
#     metadata_obj.create_all(sync_engine)    
#     sync_engine.echo = True



def create_tables():
    Base.metadata.drop_all(sync_engine)     
    sync_engine.echo = True
    Base.metadata.create_all(sync_engine)    
    sync_engine.echo = True


def insert_data():
    with session_factory() as session:
        worker_bobr = WorkersOrm(username="Bobr")
        worker_volk = WorkersOrm(username="Volk")
        # session.add(worker_bobr)
        # session.add(worker_volk)
        session.add_all([worker_bobr, worker_volk])
        session.commit()



async def insert_data():
    async with async_session_factory() as session:
        worker_bobr = WorkersOrm(username="Bobr")
        worker_volk = WorkersOrm(username="Volk")
        # session.add(worker_bobr)
        # session.add(worker_volk)
        session.add_all([worker_bobr, worker_volk]) # еще никуда ничего не отправляет -> не нужен await
                                                    # хранится в оперативе в sqlalchemy
        await session.commit()      # а вот тут уже идет запись в бд
