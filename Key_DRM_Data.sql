select * into #PhimLeCoPhi from (
select count(distinct(CustomerID)) as total_key,cast(Date as date ) as Date, 'BHD' as service_name from SalesLT.log_bhd_movieID BHD
inner join SalesLT.MV_PropertiesShowVN MV on BHD.MovieID = MV.Id
where MV.isDRM = 1
group by cast(Date as date )
Union
select count(distinct(CustomerID)) as total_key,cast(Date as date ) as Date, 'Fim+' as service_name
from SalesLT.Log_Fimplus_MovieID FPLus
inner join SalesLT.MV_PropertiesShowVN MV on FPLus.MovieID = MV.Id
where MV.isDRM = 1
group by cast(Date as date )) A ;
 select * into #PhimGoiCoPhi from (
     select count(distinct(C.[customerid ])) as total_key,L.Date,'PhimGoi' as ServiceName from SalesLT.Customers C
left join SalesLT.CustomerService Cs on C.[customerid ] = CS.CustomerID
inner join SalesLT.Log_Get_DRM_List L on C.[customerid ] = L.CustomerID
where serviceid is not null and serviceid in (60,89,148,149,150,154)
group by L.Date
                                  )B

select * from #PhimGoiCoPhi
union
select top 60 * from #PhimLeCoPhi
where Date <= '2019-08-31'
order by Date desc
