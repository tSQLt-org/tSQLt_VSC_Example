/*----------------------------------------------
-- ** Requirements **
----------------------------------------------
-- For All Orders:
-- If Order Total is  $0 to  $50:  No Discount
-- If Order Total is $50 to $50K: 10% Discount
-----------------------------------------------*/
/*--
EXEC tSQLt.DropClass 'GetDiscountTests';
--*/
GO
CREATE SCHEMA GetDiscountTests AUTHORIZATION [tSQLt.TestClass];
GO
CREATE PROCEDURE GetDiscountTests.[test no discount if amount smaller 50]
AS
BEGIN
  SELECT Discount INTO #actual FROM dbo.GetDiscount(49.00);
  SELECT TOP(0) A.* INTO #expected FROM #actual X LEFT JOIN #actual A ON 1=0;
  INSERT INTO #expected VALUES(0);
  EXEC tSQLt.AssertEqualsTable '#expected','#actual';
END;
GO
CREATE PROCEDURE GetDiscountTests.[test 10% discount if amount greater 50]
AS
BEGIN
  SELECT Discount INTO #actual FROM dbo.GetDiscount(51.00);
  SELECT TOP(0) A.* INTO #expected FROM #actual X LEFT JOIN #actual A ON 1=0;
  INSERT INTO #expected VALUES(5.1);
  EXEC tSQLt.AssertEqualsTable '#expected','#actual';
END;
GO