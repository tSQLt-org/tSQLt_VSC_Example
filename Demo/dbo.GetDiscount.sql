/*--
DROP FUNCTION IF EXISTS dbo.GetDiscount;
--*/
GO
CREATE FUNCTION dbo.GetDiscount(@amount DECIMAL(13,2))
RETURNS TABLE
AS
RETURN
  SELECT CASE WHEN @amount>=50 THEN @amount*.1 ELSE 0 END Discount;
