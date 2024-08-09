create or alter function ReturnSpForDocs 
AS
begin
    SET NOCOUNT ON;

    select
         o.[object_id],
         o.[name],
        sm.definition,
         o.create_date, 
         o.modify_date 
    into #source
    from sys.sql_modules sm
    join sys.objects o on o.object_id = sm.object_id
    where o.[type] = 'P' and o.schema_id <> 4

    MERGE SpDocs as t
    USING #source as s
    ON t.object_id = s.object_id
    WHEN MATCHED AND t.definition <> s.definition THEN
        UPDATE SET t.definition = s.definition, t.modified = 1
    WHEN NOT MATCHED THEN
        insert (
            object_id,
            [name],
            [definition],
            [create_date],
            [modify_date],
            [modified]
        ) 
        values( 
            s.object_id, 
            s.[name], 
            s.definition,
            s.create_date,
            s.modify_date,
            1
        )
    WHEN NOT MATCHED BY SOURCE THEN 
    Update set t.deleted = 1; 
    
    select [name], [definition], [modified], [deleted]
    from SpDocs
    where ( modified = 1 or deleted = 1 ) and object_id <> 350624292

end
go

ReturnSpForDocs
Use Leep
select * from SpDocs

create table SpDocs ( 
    object_id int not null primary key,
    [name] varchar(50) not null,
    [definition] NVARCHAR(max)  ,
    [create_date] DATETIME2 not null,
    [modify_date] DATETIME2 not null,
    [modified] bit not null default (0),
    [deleted] bit not null default (0)
)
drop proc Test3


create or alter proc FormatAndSaveDocs