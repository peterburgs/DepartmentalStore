
-- Insert a staff
create or alter proc sp_Staff_Insert 
@sid nvarchar(50),
@name nvarchar(255),
@phone nvarchar(10),
@salary float,
@did nvarchar(50)
as
begin
	insert into Staff
	values(@sid, @name, @phone, @salary, @did, 0)
end
go

-- Delete a staff
create or alter proc sp_Staff_Delete 
@sid nvarchar(50)
as
begin
	update Staff
	set isDeleted = 1
	where sid = @sid
end
go


-- Update a staff
create or alter proc sp_Staff_Update 
@sid nvarchar(50),
@name nvarchar(255),
@phone nvarchar(10),
@salary float,
@did nvarchar(50)
as
begin
	update Staff
	set name = @name, phone = @phone, salary = @salary, did = @did
	where sid = @sid
end
go

-- Get a specific staff by id
create or alter function fn_GetStaffById(
@sid nvarchar(50)
)
returns table
as
return 
	select *
	from Staff
	where sid = @sid and isDeleted = 0
go

-- Get a specific staff by name
create or alter function fn_GetStaffByName(
@name nvarchar(255)
)
returns table
as
return 
	select *
	from Staff
	where LOWER(name) like LOWER(@name) and isDeleted = 0
go

-- Cancel insert or update if salary < 5000000
create or alter trigger tr_Staff_ForInsert_ForUpdate
on Staff
for insert, update
as
begin
	declare @salary float
	select @salary = salary
	from inserted
	if(@salary < 5000000)
	begin
		raiserror('Staff salary must be greater or equal 5000000',16,1)
		rollback
	end
end
go

-- Get all staffs
create or alter function fn_GetAllStaffs()
returns table
as
return 
	select *
	from Staff
	where isDeleted = 0 and sid != '0'
go

-- Insert staff account information
create or alter proc sp_StaffAccount_Insert
@username nvarchar(255), 
@password nvarchar(255), 
@sid nvarchar(50)
as
begin
	Insert into StaffAccount
	values(@username, HASHBYTES('SHA2_256', @password), @sid)
end
go

-- Delete staff account information
--create or alter proc sp_StaffAccount_Delete
--@sid nvarchar(50)
--as
--begin
--	delete from StaffAccount
--	where sid = @sid
--end
--go

-- Update staff account information
create or alter proc sp_StaffAccount_Update
@password nvarchar(255), 
@sid nvarchar(50)
as
begin
	update StaffAccount
	set passwordHash = HASHBYTES('SHA2_256', @password)
	where sid = @sid
end
go

-- Get all staff account
create or alter function fn_GetAllStaffUsername()
returns table
return
	select username
	from StaffAccount
go

-- Insert admin account information
create or alter proc sp_AdminAccount_Insert
@username nvarchar(255), 
@password nvarchar(255)
as
begin
	Insert into AdminAccount
	values(@username, HASHBYTES('SHA2_256', @password))
end
go

-- Check whether a admin is logging in or not
create or alter function fn_IsAdminLogin (
	@username nvarchar(255),
	@password nvarchar(255)
)
returns bit
as
begin
	declare @passwordHash binary(32) 
	if((select count(*) from AdminAccount where username = @username) != 0)
	begin
		select @passwordHash = passwordHash
		from AdminAccount 
		where username = @username
		if(@passwordHash = HASHBYTES('SHA2_256', @password))
		begin
			return 1
		end
	end
	return 0
end
go

-- Check whether a staff is logging in or not
create or alter function fn_IsStaffLogin (
	@username nvarchar(255),
	@password nvarchar(255)
)
returns nvarchar(255)
as
begin
	declare @passwordHash binary(32) 
	if((select count(*) from StaffAccount, Staff where StaffAccount.sid = Staff.sid and Staff.isDeleted = 0 and username = @username) != 0)
	begin
		select @passwordHash = passwordHash
		from StaffAccount 
		where username = @username
		if(@passwordHash = HASHBYTES('SHA2_256', @password))
		begin
			return (select sid from StaffAccount where username = @username)
		end
	end
	return null
end
go

-- Insert a product
create or alter proc sp_Pro_Insert 
@pid nvarchar(50),
@name nvarchar(255),
@price float,
@vendor nvarchar(255),
@type nvarchar(255),
@unit nvarchar(255),
@quantity int,
@did nvarchar(50)
as
begin
	insert into Product
	values(@pid, @name, @price, @vendor, @type, @unit, @quantity, @did, 0)
end
go

-- Delete a product
create or alter proc sp_Pro_Delete 
@pid nvarchar(50)
as
begin
	update Product
	set isDeleted = 1
	where pid = @pid
end
go

-- Update a product
create or alter proc sp_Pro_Update 
@pid nvarchar(50),
@name nvarchar(255),
@price float,
@vendor nvarchar(255),
@type nvarchar(255),
@unit nvarchar(255),
@did nvarchar(50)
as
begin
	update Product
	set name = @name, price = @price, vendor = @vendor, type = @type, unit = @unit, did = @did
	where pid = @pid
end
go

-- Get all products
create or alter function fn_GetAllProducts()
returns table
as
return 
	select *
	from Product
	where isDeleted = 0
go

-- Get a specific product by id
create or alter function fn_GetProductById(
@pid nvarchar(50)
)
returns table
as
return 
	select *
	from Product
	where pid like @pid and isDeleted = 0
go


-- Get a specific product by name
create or alter function fn_GetProductByName(
@name nvarchar(255)
)
returns table
as
return 
	select *
	from Product
	where LOWER(name) like LOWER(@name) and isDeleted = 0
go

-- Insert a customer
create or alter proc sp_Customer_Insert 
@cid nvarchar(50),
@name nvarchar(255),
@phone nvarchar(10),
@points int,
@did nvarchar(50)
as
begin
	insert into Customer
	values(@cid, @name, @phone, @points, @did, 0)
end
go

-- Delete a customer
create or alter proc sp_Customer_Delete 
@cid nvarchar(50)
as
begin
	update Customer
	set isDeleted = 1
	where cid = @cid
end
go

-- Update a customer
create or alter proc sp_Customer_Update 
@cid nvarchar(50),
@name nvarchar(255),
@phone nvarchar(10),
@points int,
@did nvarchar(50)
as
begin
	update Customer
	set name = @name, phone = @phone, points = @points, did = @did
	where cid = @cid
end
go

-- Get all customers
create or alter function fn_GetAllCustomers()
returns table
as
return 
	select *
	from Customer
	where isDeleted = 0
go

-- Get a customer by customer id
create or alter function fn_GetCustomerById(
@cid nvarchar(50)
)
returns table
as
return 
	select *
	from Customer
	where cid = @cid and isDeleted = 0
go

-- Get a customer by customer name
create or alter function fn_GetCustomerByName(
@name nvarchar(255)
)
returns table
as
return 
	select *
	from Customer
	where LOWER(name) like LOWER(@name) and isDeleted = 0
go

-- Insert a batch
create or alter proc sp_Batch_Insert 
@bid nvarchar(50),
@importDate datetime,
@expirationDate datetime,
@quantity int,
@pid nvarchar(255)
as
begin
	insert into Batch
	values(@bid, @importDate, @expirationDate, @quantity, @pid)
end
go

-- Delete a batch
create or alter proc sp_Batch_Delete 
@bid nvarchar(50)
as
begin
	delete from Batch
	where bid = @bid
end
go

-- Update a batch
create or alter proc sp_Batch_Update 
@bid nvarchar(50),
@quantity int
as
begin
	update Batch
	set quantity = quantity - @quantity
	where bid = @bid
end
go

-- Get batch by id
create or alter function fn_GetBatchById (
@bid nvarchar(50)
)
returns table
return
	select Batch.bid, Batch.importDate, Batch.expirationDate, Batch.quantity, Batch.pid
	from Batch, Product
	where Batch.pid = Product.pid and Product.isDeleted = 0 and bid = @bid
go

-- Check if expirationDate - importDate >= 30 or not
create or alter trigger tr_Batch_ForInsert
on Batch
for insert
as
begin
	declare @expirationDate date
	select @expirationDate = expirationDate
	from inserted
	declare @importDate date
	select @importDate = importDate
	from inserted
	if(CAST(DATEDIFF(day, @importDate, @expirationDate) AS INT) < 30)
	begin
		RAISERROR('Expiration date must be greater than import date at least 30 days',16, 1)
		rollback
	end
end
go

-- Update quantity of product after insert a batch
create or alter trigger tr_Batch_AfterInsert
on Batch
after insert
as
begin
	declare @quantity int
	select @quantity = quantity
	from inserted
	declare @pid nvarchar(50)
	select @pid = pid
	from inserted
	
	update Product
	set quantity = quantity + @quantity
	where pid = @pid
end
go

-- Update quantity of product after update a batch
create or alter trigger tr_Batch_AfterUpdate
on Batch
after update
as
begin
	declare @new_quantity int
	select @new_quantity = quantity
	from inserted
	declare @old_quantity int
	select @old_quantity = quantity
	from deleted
	declare @pid nvarchar(50)
	select @pid = pid
	from inserted
	declare @bid nvarchar(50)
	select @bid = bid
	from inserted

	if(@new_quantity = 0)
	begin
		delete from Batch
		where bid = @bid

		update Product
		set quantity = 0
		where pid = @pid
	end
	else
	begin
		if(@new_quantity < @old_quantity)
		begin
			update Product
			set quantity = quantity - (@old_quantity - @new_quantity)
			where pid = @pid
		end
		else
		begin
			update Product
			set quantity = quantity + (@new_quantity - @old_quantity)
			where pid = @pid
		end
	end
end
go

-- Get the batch of a specific product by product id
create or alter function fn_GetBatchByProductId (
@pid nvarchar(50)
)
returns table
return
	select *
	from Batch
	where pid = @pid and DATEDIFF(day, importDate, GETDATE()) = (select MAX(DATEDIFF(DAY,importDate,GETDATE())) from Batch where pid = @pid)
go

create or alter function fn_GetBatchesByProductId (
@pid nvarchar(50)
)
returns table
return
	select *
	from Batch
	where pid = @pid
go

-- Insert a purchase
create or alter proc sp_Purchase_Insert 
@pcid nvarchar(50),
@sid nvarchar(50),
@cid nvarchar(50),
@date datetime,
@value float
as
begin
	insert into Purchase
	values(@pcid, @sid, @cid, @date, @value)
end
go

-- Delete a purchase
create or alter proc sp_Purchase_Delete 
@pcid nvarchar(50)
as
begin
	delete from Purchase
	where pcid = @pcid
end
go

-- Update a purchase
create or alter proc sp_Purchase_Update 
@pcid nvarchar(50),
@sid nvarchar(50),
@cid nvarchar(50),
@date datetime,
@value float
as
begin
	update Purchase
	set sid = @sid, cid = @cid, date = @date, value = @value
	where pcid = @pcid
end
go

-- Get all purchases
create or alter function fn_GetAllPurchases()
returns table
as
return 
	select *
	from Purchase
go


-- Get daily income
create or alter function fn_GetDailyIncome()
returns float
as
begin
	declare @dailyIncome float
	select @dailyIncome = sum(value)
	from Purchase
	where DAY(date) = DAY(getdate())

	return @dailyIncome
end
go

-- Get mothly income
create or alter function fn_GetMonthlyIncome()
returns @MonthlyIncome table
(
	Jan float,
	Feb float,
	Mar float,
	Apr float,
	May float,
	Jun float,
	Jul float,
	Aug float,
	Sep float,
	Oct float,
	Nov float,
	Dec float
)
as
begin
	declare @Jan float
	select @Jan = sum(value)
	from Purchase
	where MONTH(date) = 1 and YEAR(date) = YEAR(getdate())

	declare @Feb float
	select @Feb = sum(value)
	from Purchase
	where MONTH(date) = 2 and YEAR(date) = YEAR(getdate())

	declare @Mar float
	select @Mar = sum(value)
	from Purchase
	where MONTH(date) = 3 and YEAR(date) = YEAR(getdate())

	declare @Apr float
	select @Apr = sum(value)
	from Purchase
	where MONTH(date) = 4 and YEAR(date) = YEAR(getdate())

	declare @May float
	select @May = sum(value)
	from Purchase
	where MONTH(date) = 5 and YEAR(date) = YEAR(getdate())

	declare @Jun float
	select @Jun = sum(value)
	from Purchase
	where MONTH(date) = 6 and YEAR(date) = YEAR(getdate())

	declare @Jul float
	select @Jul = sum(value)
	from Purchase
	where MONTH(date) = 7 and YEAR(date) = YEAR(getdate())

	declare @Aug float
	select @Aug = sum(value)
	from Purchase
	where MONTH(date) = 8 and YEAR(date) = YEAR(getdate())

	declare @Sep float
	select @Sep = sum(value)
	from Purchase
	where MONTH(date) = 9 and YEAR(date) = YEAR(getdate())

	declare @Oct float
	select @Oct = sum(value)
	from Purchase
	where MONTH(date) = 10 and YEAR(date) = YEAR(getdate())

	declare @Nov float
	select @Nov = sum(value)
	from Purchase
	where MONTH(date) = 11 and YEAR(date) = YEAR(getdate())

	declare @Dec float
	select @Dec = sum(value)
	from Purchase
	where MONTH(date) = 12 and YEAR(date) = YEAR(getdate())

	insert into @MonthlyIncome
	values(@Jan,@Feb,@Mar,@Apr,@May,@Jun,@Jul,@Aug,@Sep,@Oct,@Nov,@Dec)

	return
end
go

-- update point for customer
create or alter trigger tr_Purchase_AfterInsert
on Purchase
after insert
as
begin
	declare @cid nvarchar(50)
	select @cid = cid
	from inserted

	declare @value float
	select @value = value
	from inserted

	declare @date datetime
	select @date = date
	from inserted

	if(@cid != '')
	begin
		update Customer
		set points = points + @value/1000
		where cid = @cid
	end
	
	if(MONTH(@date) = 1)
	begin
		update MonthlyIncome
		set Jan = Jan + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 2)
	begin
		update MonthlyIncome
		set Feb = Feb + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 3)
	begin
		update MonthlyIncome
		set Mar = Mar + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 4)
	begin
		update MonthlyIncome
		set Apr = Apr + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 5)
	begin
		update MonthlyIncome
		set May = May + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 6)
	begin
		update MonthlyIncome
		set Jun = Jun + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 7)
	begin
		update MonthlyIncome
		set Jul = Jul + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 8)
	begin
		update MonthlyIncome
		set Aug = Aug + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 9)
	begin
		update MonthlyIncome
		set Sep = Sep + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 10)
	begin
		update MonthlyIncome
		set Oct = Oct + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 11)
	begin
		update MonthlyIncome
		set Nov = Nov + @value
		where Year = YEAR(@date)
	end

	if(MONTH(@date) = 12)
	begin
		update MonthlyIncome
		set Dec = Dec + @value
		where Year = YEAR(@date)
	end
	
end
go

-- Insert a detail
create or alter proc sp_Detail_Insert 
@pcid nvarchar(50),
@pid nvarchar(50),
@quantity int
as
begin
	declare @price float
	select @price = price
	from Product
	where pid = @pid

	declare @value float
	set @value = @price * @quantity

	insert into Detail
	values(@pcid, @pid, @quantity, @value)
end
go

-- Update detail
create or alter proc sp_Detail_Update 
@pcid nvarchar(50),
@pid nvarchar(50),
@quantity int
as
begin
	declare @price float
	select @price = price
	from Product
	where pid = @pid

	declare @value float
	set @value = @price * @quantity

	update Detail
	set quantity = @quantity, value = @value
	where pcid = @pcid and pid = @pid
end
go

-- Get detail
create or alter function fn_GetDetail(
@pcid nvarchar(50),
@pid nvarchar(50)
)
returns table
return
	select *
	from Detail
	where pcid = @pcid and pid = @pid
go


-- Check if quantity is greater than 0 or not
create or alter trigger tr_Detail_ForInsert
on Detail
for insert
as
begin
	declare @quantity int
	select @quantity = quantity
	from inserted
	if(@quantity < 1)
	begin
		RAISERROR('Quantity must be greater than 0',16,1)
		rollback
	end
end
go

-- Get details of a specific purchase
create or alter function fn_GetDetails(
@pcid nvarchar(50)
)
returns table
return 
	select *
	from Detail
	where pcid = @pcid
go

-- Get image reference by product id
create or alter function fn_GetImageReferenceByProductId (
@pid nvarchar(50)
)
returns table
return
	select *
	from ImageReference
	where pid = @pid
go

create or alter procedure sp_ImageReference_Insert
@id nvarchar(50),
@path nvarchar(255),
@pid nvarchar(50)
as
begin
	Insert into ImageReference
	values(@id, @path, @pid)
end
go

create or alter procedure sp_ImageReference_Update
@id nvarchar(50),
@path nvarchar(255),
@pid nvarchar(50)
as
begin
	update ImageReference
	set path = @path, pid = @pid
	where id = @id
end
go
