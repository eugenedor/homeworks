CREATE TABLE #t (i int, x xml);
  
INSERT INTO #t VALUES(1, '
<Root>  
  <ProductDescription ProductID="1" ProductName="Road Bike">  
    <Features>  
      <Warranty>1 year parts and labor</Warranty>  
      <Maintenance>3 year parts and labor extended maintenance is available</Maintenance>  
    </Features>  
  </ProductDescription>  
</Root>'
)  

-- verify the current <ProductDescription> element  
SELECT x.query(' /Root/ProductDescription')  
FROM #t

-- update the ProductName attribute value  
UPDATE #t  
SET x.modify('  
  replace value of (/Root/ProductDescription/@ProductName)[1]  
  with "New Road Bike" '
)
      
-- verify the update  
SELECT x.query(' /Root/ProductDescription')  
FROM #t 

DROP TABLE #t
GO