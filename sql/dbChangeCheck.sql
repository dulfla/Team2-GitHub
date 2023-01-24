SELECT c.category, c.icon , NVL("count",0) AS "cnt"
		FROM category c LEFT OUTER JOIN (SELECT category, COUNT(*) AS "count" FROM productDetail GROUP BY category) pd
        ON c.category=pd.category
		ORDER BY category ASC;
        
        select * from category;
        select * from productDetail;
        
        update category
        set category='디지털기기'
        where category='디지털 기기'