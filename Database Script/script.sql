USE [master]
GO
/****** Object:  Database [DepartmentalStoreManagement]    Script Date: 21/12/2019 6:01:22 PM ******/
CREATE DATABASE [DepartmentalStoreManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DepartmentalStoreManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\DepartmentalStoreManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DepartmentalStoreManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\DepartmentalStoreManagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DepartmentalStoreManagement] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DepartmentalStoreManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DepartmentalStoreManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET RECOVERY FULL 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET  MULTI_USER 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DepartmentalStoreManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DepartmentalStoreManagement] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DepartmentalStoreManagement', N'ON'
GO
ALTER DATABASE [DepartmentalStoreManagement] SET QUERY_STORE = OFF
GO
USE [DepartmentalStoreManagement]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDailyIncome]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Get daily income
create   function [dbo].[fn_GetDailyIncome]()
returns float
as
begin
	declare @dailyIncome float
	select @dailyIncome = sum(value)
	from Purchase
	where DAY(date) = DAY(getdate())

	return @dailyIncome
end
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetMonthlyIncome]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get mothly income
create   function [dbo].[fn_GetMonthlyIncome]()
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
GO
/****** Object:  UserDefinedFunction [dbo].[fn_IsAdminLogin]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Check whether a admin is logging in or not
create   function [dbo].[fn_IsAdminLogin] (
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
GO
/****** Object:  UserDefinedFunction [dbo].[fn_IsStaffLogin]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Check whether a staff is logging in or not
create   function [dbo].[fn_IsStaffLogin] (
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
GO
/****** Object:  Table [dbo].[Product]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[pid] [nvarchar](50) NOT NULL,
	[name] [nvarchar](255) NULL,
	[price] [float] NULL,
	[vendor] [nvarchar](255) NULL,
	[type] [nvarchar](255) NULL,
	[unit] [nvarchar](255) NULL,
	[quantity] [int] NULL,
	[did] [nvarchar](50) NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetProductById]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get a specific product by id
create   function [dbo].[fn_GetProductById](
@pid nvarchar(50)
)
returns table
as
return 
	select *
	from Product
	where pid = @pid and isDeleted = 0
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetProductByName]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Get a specific product by name
create   function [dbo].[fn_GetProductByName](
@name nvarchar(255)
)
returns table
as
return 
	select *
	from Product
	where LOWER(name) = LOWER(@name) and isDeleted = 0
GO
/****** Object:  Table [dbo].[ImageReference]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageReference](
	[id] [nvarchar](50) NOT NULL,
	[path] [nvarchar](255) NULL,
	[pid] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetImageReferenceByProductId]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get image reference by product id
create   function [dbo].[fn_GetImageReferenceByProductId] (
@pid nvarchar(50)
)
returns table
return
	select *
	from ImageReference
	where pid = @pid
GO
/****** Object:  Table [dbo].[Batch]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Batch](
	[bid] [nvarchar](50) NOT NULL,
	[importDate] [datetime] NULL,
	[expirationDate] [datetime] NULL,
	[quantity] [int] NULL,
	[pid] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[bid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetBatchByProductId]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get the batch of a specific product by product id
create   function [dbo].[fn_GetBatchByProductId] (
@pid nvarchar(50)
)
returns table
return
	select *
	from Batch
	where pid = @pid and DATEDIFF(day, importDate, GETDATE()) = (select MAX(DATEDIFF(DAY,importDate,GETDATE())) from Batch where pid = @pid)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetBatchById]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get batch by id
create   function [dbo].[fn_GetBatchById] (
@bid nvarchar(50)
)
returns table
return
	select Batch.bid, Batch.importDate, Batch.expirationDate, Batch.quantity, Batch.pid
	from Batch, Product
	where Batch.pid = Product.pid and Product.isDeleted = 0 and bid = @bid
GO
/****** Object:  Table [dbo].[Purchase]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchase](
	[pcid] [nvarchar](50) NOT NULL,
	[sid] [nvarchar](50) NULL,
	[cid] [nvarchar](50) NULL,
	[date] [datetime] NULL,
	[value] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[pcid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetAllPurchases]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get all purchases
create   function [dbo].[fn_GetAllPurchases]()
returns table
as
return 
	select *
	from Purchase
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[sid] [nvarchar](50) NOT NULL,
	[name] [nvarchar](255) NULL,
	[phone] [nvarchar](10) NULL,
	[salary] [float] NULL,
	[did] [nvarchar](50) NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetStaffById]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get a specific staff by id
create   function [dbo].[fn_GetStaffById](
@sid nvarchar(50)
)
returns table
as
return 
	select *
	from Staff
	where sid = @sid and isDeleted = 0
GO
/****** Object:  Table [dbo].[StaffAccount]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffAccount](
	[username] [nvarchar](255) NOT NULL,
	[passwordHash] [binary](32) NULL,
	[sid] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetAllStaffUsername]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get all staff account
create   function [dbo].[fn_GetAllStaffUsername]()
returns table
return
	select username
	from StaffAccount
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetStaffByName]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get a specific staff by name
create   function [dbo].[fn_GetStaffByName](
@name nvarchar(255)
)
returns table
as
return 
	select *
	from Staff
	where LOWER(name) = LOWER(@name) and isDeleted = 0
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[cid] [nvarchar](50) NOT NULL,
	[name] [nvarchar](255) NULL,
	[phone] [nvarchar](10) NULL,
	[points] [int] NULL,
	[did] [nvarchar](50) NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[cid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCustomerById]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get a customer by customer id
create   function [dbo].[fn_GetCustomerById](
@cid nvarchar(50)
)
returns table
as
return 
	select *
	from Customer
	where cid = @cid and isDeleted = 0
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCustomerByName]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get a customer by customer name
create   function [dbo].[fn_GetCustomerByName](
@name nvarchar(255)
)
returns table
as
return 
	select *
	from Customer
	where LOWER(name) = LOWER(@name) and isDeleted = 0
GO
/****** Object:  Table [dbo].[Detail]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail](
	[pcid] [nvarchar](50) NOT NULL,
	[pid] [nvarchar](50) NOT NULL,
	[quantity] [int] NULL,
	[value] [float] NULL,
 CONSTRAINT [PK_Detail] PRIMARY KEY CLUSTERED 
(
	[pcid] ASC,
	[pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDetail]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get detail
create   function [dbo].[fn_GetDetail](
@pcid nvarchar(50),
@pid nvarchar(50)
)
returns table
return
	select *
	from Detail
	where pcid = @pcid and pid = @pid
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetAllStaffs]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Get all staffs
create   function [dbo].[fn_GetAllStaffs]()
returns table
as
return 
	select *
	from Staff
	where isDeleted = 0 and sid != '0'
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetBatchesByProductId]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[fn_GetBatchesByProductId] (
@pid nvarchar(50)
)
returns table
return
	select *
	from Batch
	where pid = @pid
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetAllProducts]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get all products
create   function [dbo].[fn_GetAllProducts]()
returns table
as
return 
	select *
	from Product
	where isDeleted = 0
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetAllCustomers]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get all customers
create   function [dbo].[fn_GetAllCustomers]()
returns table
as
return 
	select *
	from Customer
	where isDeleted = 0
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetAllProductsIncludingDeleted]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[fn_GetAllProductsIncludingDeleted]()
returns table
as
return
	select *
	from product
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetAllCustomersIncludingDeleted]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[fn_GetAllCustomersIncludingDeleted]()
returns table
as
return
	select *
	from customer
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetAllStaffsIncludingDeleted]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[fn_GetAllStaffsIncludingDeleted]()
returns table
as
return
	select *
	from staff
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDetails]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Get details of a specific purchase
create   function [dbo].[fn_GetDetails](
@pcid nvarchar(50)
)
returns table
return 
	select *
	from Detail
	where pcid = @pcid
GO
/****** Object:  Table [dbo].[AdminAccount]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminAccount](
	[username] [nvarchar](255) NOT NULL,
	[passwordHash] [binary](32) NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepartmentalStore]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentalStore](
	[did] [nvarchar](50) NOT NULL,
	[address] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[did] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MonthlyIncome]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonthlyIncome](
	[Year] [int] NOT NULL,
	[Jan] [float] NULL,
	[Feb] [float] NULL,
	[Mar] [float] NULL,
	[Apr] [float] NULL,
	[May] [float] NULL,
	[Jun] [float] NULL,
	[Jul] [float] NULL,
	[Aug] [float] NULL,
	[Sep] [float] NULL,
	[Oct] [float] NULL,
	[Nov] [float] NULL,
	[Dec] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD FOREIGN KEY([pid])
REFERENCES [dbo].[Product] ([pid])
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD FOREIGN KEY([did])
REFERENCES [dbo].[DepartmentalStore] ([did])
GO
ALTER TABLE [dbo].[Detail]  WITH CHECK ADD FOREIGN KEY([pcid])
REFERENCES [dbo].[Purchase] ([pcid])
GO
ALTER TABLE [dbo].[Detail]  WITH CHECK ADD FOREIGN KEY([pid])
REFERENCES [dbo].[Product] ([pid])
GO
ALTER TABLE [dbo].[ImageReference]  WITH CHECK ADD FOREIGN KEY([pid])
REFERENCES [dbo].[Product] ([pid])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([did])
REFERENCES [dbo].[DepartmentalStore] ([did])
GO
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD FOREIGN KEY([cid])
REFERENCES [dbo].[Customer] ([cid])
GO
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD FOREIGN KEY([sid])
REFERENCES [dbo].[Staff] ([sid])
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD FOREIGN KEY([did])
REFERENCES [dbo].[DepartmentalStore] ([did])
GO
ALTER TABLE [dbo].[StaffAccount]  WITH CHECK ADD FOREIGN KEY([sid])
REFERENCES [dbo].[Staff] ([sid])
GO
/****** Object:  StoredProcedure [dbo].[sp_AdminAccount_Insert]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert admin account information
create   proc [dbo].[sp_AdminAccount_Insert]
@username nvarchar(255), 
@password nvarchar(255)
as
begin
	Insert into AdminAccount
	values(@username, HASHBYTES('SHA2_256', @password))
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Batch_Delete]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a batch
create   proc [dbo].[sp_Batch_Delete] 
@bid nvarchar(50)
as
begin
	delete from Batch
	where bid = @bid
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Batch_Insert]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a batch
create   proc [dbo].[sp_Batch_Insert] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_Batch_Update]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update a batch
create   proc [dbo].[sp_Batch_Update] 
@bid nvarchar(50),
@quantity int
as
begin
	update Batch
	set quantity = quantity - @quantity
	where bid = @bid
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Delete]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a customer
create   proc [dbo].[sp_Customer_Delete] 
@cid nvarchar(50)
as
begin
	update Customer
	set isDeleted = 1
	where cid = @cid
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Insert]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a customer
create   proc [dbo].[sp_Customer_Insert] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Update]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update a customer
create   proc [dbo].[sp_Customer_Update] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_Detail_Insert]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a detail
create   proc [dbo].[sp_Detail_Insert] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_Detail_Update]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update detail
create   proc [dbo].[sp_Detail_Update] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_ImageReference_Insert]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   procedure [dbo].[sp_ImageReference_Insert]
@id nvarchar(50),
@path nvarchar(255),
@pid nvarchar(50)
as
begin
	Insert into ImageReference
	values(@id, @path, @pid)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ImageReference_Update]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   procedure [dbo].[sp_ImageReference_Update]
@id nvarchar(50),
@path nvarchar(255),
@pid nvarchar(50)
as
begin
	update ImageReference
	set path = @path, pid = @pid
	where id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Pro_Delete]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a product
create   proc [dbo].[sp_Pro_Delete] 
@pid nvarchar(50)
as
begin
	update Product
	set isDeleted = 1
	where pid = @pid
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Pro_Insert]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a product
create   proc [dbo].[sp_Pro_Insert] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_Pro_Update]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update a product
create   proc [dbo].[sp_Pro_Update] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_Purchase_Delete]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a purchase
create   proc [dbo].[sp_Purchase_Delete] 
@pcid nvarchar(50)
as
begin
	delete from Purchase
	where pcid = @pcid
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Purchase_Insert]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a purchase
create   proc [dbo].[sp_Purchase_Insert] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_Purchase_Update]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update a purchase
create   proc [dbo].[sp_Purchase_Update] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_Staff_Delete]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a staff
create   proc [dbo].[sp_Staff_Delete] 
@sid nvarchar(50)
as
begin
	update Staff
	set isDeleted = 1
	where sid = @sid
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Staff_Insert]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a staff
create   proc [dbo].[sp_Staff_Insert] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_Staff_Update]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Update a staff
create   proc [dbo].[sp_Staff_Update] 
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
GO
/****** Object:  StoredProcedure [dbo].[sp_StaffAccount_Insert]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert staff account information
create   proc [dbo].[sp_StaffAccount_Insert]
@username nvarchar(255), 
@password nvarchar(255), 
@sid nvarchar(50)
as
begin
	Insert into StaffAccount
	values(@username, HASHBYTES('SHA2_256', @password), @sid)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_StaffAccount_Update]    Script Date: 21/12/2019 6:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
create   proc [dbo].[sp_StaffAccount_Update]
@password nvarchar(255), 
@sid nvarchar(50)
as
begin
	update StaffAccount
	set passwordHash = HASHBYTES('SHA2_256', @password)
	where sid = @sid
end
GO
USE [master]
GO
ALTER DATABASE [DepartmentalStoreManagement] SET  READ_WRITE 
GO
