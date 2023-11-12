/*--
EXEC tSQLt.DropClass 'RevisionReportTests';
--*/
GO
CREATE SCHEMA RevisionReportTests AUTHORIZATION [tSQLt.TestClass];
GO
CREATE PROCEDURE RevisionReportTests.[test returns discount information]
AS
BEGIN
  EXEC tSQLt.FakeTable 'dbo.Orders'
  INSERT INTO dbo.Orders(Id,Total)VALUES(1,25),(2,50);
  SELECT Id, PreDiscountTotal, Discount, Total 
    INTO #actual
    FROM dbo.RevisionReport;
  SELECT TOP(0) A.* INTO #expected FROM #actual X LEFT JOIN #actual A ON 1=0;
  INSERT INTO #expected VALUES(1,25,0,25),(2,50,0,50);
  EXEC tSQLt.AssertEqualsTable '#expected','#actual';
END;
GO


GO
CREATE FUNCTION [returns 12%](@amount DECIMAL(13,2)) 
  RETURNS TABLE AS 
  RETURN SELECT @amount*.12 Discount;
GO
CREATE PROCEDURE RevisionReportTests.[test uses dbo.GetDiscount to calculate discount information]
AS
BEGIN
  EXEC tSQLt.FakeTable 'dbo.Orders'
  INSERT INTO dbo.Orders(Id,Total)VALUES(1,24),(2,30);
  SELECT Id, PreDiscountTotal, Discount, Total 
    INTO #actual
    FROM dbo.RevisionReport;
  SELECT TOP(0) A.* INTO #expected FROM #actual X LEFT JOIN #actual A ON 1=0;
  INSERT INTO #expected VALUES(1,24,2.68,21.32),(2,30,3.90,26.10);
  EXEC tSQLt.AssertEqualsTable '#expected','#actual';
END;
GO
