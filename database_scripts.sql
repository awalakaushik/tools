-- Script to drop column with default constraints
DECLARE @ConstraintName nvarchar(200)
SELECT @ConstraintName = Name FROM SYS.DEFAULT_CONSTRAINTS WHERE PARENT_OBJECT_ID = OBJECT_ID('__TableName__') AND PARENT_COLUMN_ID = (SELECT column_id FROM sys.columns WHERE NAME = N'__ColumnName__' AND object_id = OBJECT_ID(N'__TableName__'))
IF @ConstraintName IS NOT NULL
EXEC('ALTER TABLE __TableName__ DROP CONSTRAINT ' + @ConstraintName)
IF EXISTS (SELECT * FROM syscolumns WHERE id=object_id('__TableName__') AND name='__ColumnName__')
EXEC('ALTER TABLE __TableName__ DROP COLUMN __ColumnName__')

-- Script to drop foreign keys and other type of constraints
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE where TABLE_NAME = '__TableName__' AND COLUMN_NAME = '__ColumnName__')
BEGIN
SELECT @ConstraintName = CONSTRAINT_NAME FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE where TABLE_NAME = '__TableName__' AND COLUMN_NAME = '__ColumnName__'
EXEC('ALTER TABLE __TableName__ DROP CONSTRAINT ' + @ConstraintName)
END

-- Just replace __TableName__ and __ColumnName__ with the appropriate values.  You can safely run this even if the column has already been dropped.

-- Credits: http://www.archonsystems.com/devblog/2012/05/25/how-to-drop-a-column-with-a-default-value-constraint-in-sql-server/
