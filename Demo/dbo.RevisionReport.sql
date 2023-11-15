/*--
DROP VIEW IF EXISTS dbo.RevisionReport;
--*/
GO
CREATE VIEW dbo.RevisionReport
AS
  SELECT 
      O.Id, 
      O.CustomerId, 
      O.Total AS PreDiscountTotal, 
      D.Discount, 
      O.Total - D.Discount AS Total
    FROM dbo.Orders O
   CROSS APPLY dbo.GetDiscount(O.Total) D;
