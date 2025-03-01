USE [master]
GO
/****** Object:  Database [CrudPractics]    Script Date: 11-10-2024 18:24:30 ******/
CREATE DATABASE [CrudPractics]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CrudPractics', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\CrudPractics.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CrudPractics_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\CrudPractics_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CrudPractics] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CrudPractics].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CrudPractics] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CrudPractics] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CrudPractics] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CrudPractics] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CrudPractics] SET ARITHABORT OFF 
GO
ALTER DATABASE [CrudPractics] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CrudPractics] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CrudPractics] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CrudPractics] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CrudPractics] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CrudPractics] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CrudPractics] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CrudPractics] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CrudPractics] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CrudPractics] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CrudPractics] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CrudPractics] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CrudPractics] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CrudPractics] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CrudPractics] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CrudPractics] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CrudPractics] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CrudPractics] SET RECOVERY FULL 
GO
ALTER DATABASE [CrudPractics] SET  MULTI_USER 
GO
ALTER DATABASE [CrudPractics] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CrudPractics] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CrudPractics] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CrudPractics] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CrudPractics] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CrudPractics', N'ON'
GO
ALTER DATABASE [CrudPractics] SET QUERY_STORE = OFF
GO
USE [CrudPractics]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [CrudPractics]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](200) NULL,
	[StatusId] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](200) NULL,
	[Category] [bigint] NULL,
	[StatusID] [tinyint] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Address] [nvarchar](200) NULL,
	[StatusId] [tinyint] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_StatusID]  DEFAULT ((1)) FOR [StatusID]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  StoredProcedure [dbo].[GetCategory]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetCategory]
@ID bigint 
as
begin 
 IF(@ID = -1)
 BEGIN
  select * from Category   where statusid = 1
 END
 ELSE
 BEGIN
  select * from Category  where id = @ID and statusid = 1
 END
End

GO
/****** Object:  StoredProcedure [dbo].[GetCategoty]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetCategoty]
as
begin 
select ID as CategoryId, CategoryName from category where statusid = 1
end
GO
/****** Object:  StoredProcedure [dbo].[GetProduct]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetProduct]
@ID bigint 
as
begin 
 IF(@ID = -1)
 BEGIN
  select  P.ID , P.ProductName , C.CategoryName , C.ID as CategoryId , P.StatusID from Product  P
  inner join category c on c.id	= p.category  where P.statusid = 1
 END
 ELSE
 BEGIN
  select P.ID , P.ProductName , C.ID as CategoryId , C.CategoryName   , P.StatusID from Product  p
  inner join category c on c.id	= p.category 
  where p.id = @ID and  P.statusid = 1
 END
End
GO
/****** Object:  StoredProcedure [dbo].[GetProductCount]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetProductCount]
AS
BEGIN
    SET NOCOUNT ON;

    -- Get the total count of products with StatusID = 1
    SELECT COUNT(*) AS TotalCount 
    FROM Product 
    WHERE StatusID = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[GetProductList]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProductList]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Calculate the starting row number
    DECLARE @StartRow INT = (@PageNumber - 1) * @PageSize + 1;
    DECLARE @EndRow INT = @PageNumber * @PageSize;

    -- Select the products with pagination
    SELECT *
    FROM (
        SELECT 
            P.ID, 
            P.ProductName, 
            C.CategoryName, 
            C.ID AS CategoryId,
            ROW_NUMBER() OVER (ORDER BY P.ID) AS RowNum
        FROM 
            Product P
        INNER JOIN 
            Category C ON C.ID = P.Category
        WHERE 
            P.StatusID = 1
    ) AS ProductList
    WHERE RowNum BETWEEN @StartRow AND @EndRow;
END


GO
/****** Object:  StoredProcedure [dbo].[GetUser]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetUser]
@ID bigint 
as
begin 
 IF(@ID = -1)
 BEGIN
  select * from users  
 END
 ELSE
 BEGIN
  select * from users  where id = @ID
 END
End
GO
/****** Object:  StoredProcedure [dbo].[SaveCategory]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  procedure [dbo].[SaveCategory]
@ID bigint = 0 ,
@Name nvarchar(200)
as
begin 
if(@ID = 0)
begin 
INSert into Category (CategoryName)
values(@Name)
end
else
begin 
update Category set CategoryName = @Name  where id = @ID
end

end
GO
/****** Object:  StoredProcedure [dbo].[SaveProduct]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SaveProduct]
@ID bigint = 0 ,
@Name nvarchar(200),
@Category bigint = 0 
as
begin 
if(@ID = 0)
begin 
INSert into Product (ProductName, Category)
values(@Name , @Category)
end
else
begin 
update Product set ProductName = @Name , Category = @Category where id = @ID
end

end
GO
/****** Object:  StoredProcedure [dbo].[SaveUsers]    Script Date: 11-10-2024 18:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SaveUsers]
@ID bigint = 0 ,
@Name nvarchar(200),
@Address nvarchar(200)
as
begin 
if(@ID = 0)
begin 
INSert into Users (Name, Address)
values(@Name , @Address)
end
else
begin 
update Users set Name = @Name , Address = @Address where id = @ID
end

end
GO
USE [master]
GO
ALTER DATABASE [CrudPractics] SET  READ_WRITE 
GO
