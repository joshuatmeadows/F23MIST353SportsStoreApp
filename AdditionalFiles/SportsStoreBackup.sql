USE [master]
GO
/****** Object:  Database [SportsStoreDB]    Script Date: 10/17/2023 9:25:15 AM ******/
CREATE DATABASE [SportsStoreDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SportsStoreDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SportsStoreDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SportsStoreDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SportsStoreDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SportsStoreDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SportsStoreDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SportsStoreDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SportsStoreDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SportsStoreDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SportsStoreDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SportsStoreDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SportsStoreDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SportsStoreDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SportsStoreDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SportsStoreDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SportsStoreDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SportsStoreDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SportsStoreDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SportsStoreDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SportsStoreDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SportsStoreDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SportsStoreDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SportsStoreDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SportsStoreDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SportsStoreDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SportsStoreDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SportsStoreDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SportsStoreDB] SET RECOVERY FULL 
GO
ALTER DATABASE [SportsStoreDB] SET  MULTI_USER 
GO
ALTER DATABASE [SportsStoreDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SportsStoreDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SportsStoreDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SportsStoreDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SportsStoreDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SportsStoreDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SportsStoreDB', N'ON'
GO
ALTER DATABASE [SportsStoreDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [SportsStoreDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SportsStoreDB]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCartQuantity]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- First, we create a user defined function for convience.
CREATE   FUNCTION [dbo].[GetCartQuantity](@CartID char(36), @ProductID int)
RETURNS int
AS
-- Returns the cart quantity for the product.
BEGIN
    DECLARE @count int;
    SELECT @count = sum(Quantity)
    FROM ShoppingCart
    WHERE ProductID = @ProductID
        AND CartID = @CartID;
     IF (@count IS NULL) -- if no product in cart, return 0 (instead of null) for convience
        SET @count = 0;
    RETURN @count;
END;
GO
/****** Object:  Table [dbo].[Category]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [pk_category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [char](36) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](max) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[CreditCard] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC,
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataCollectionTools]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataCollectionTools](
	[ToolID] [int] IDENTITY(600,1) NOT NULL,
	[ToolName] [nvarchar](255) NOT NULL,
	[Units] [nvarchar](255) NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[IsDigital] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ToolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Institutions]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Institutions](
	[InstitutionID] [int] IDENTITY(300,1) NOT NULL,
	[InstitutionName] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](1000) NOT NULL,
	[ContactNumber] [nvarchar](15) NULL,
	[Location] [nvarchar](255) NULL,
	[Department] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[InstitutionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Observations]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Observations](
	[ObservationID] [int] IDENTITY(700,1) NOT NULL,
	[Value] [float] NULL,
	[ObservedDate] [datetime2](7) NOT NULL,
	[Notes] [nvarchar](1000) NOT NULL,
	[ToolID] [int] NULL,
	[Latitude] [decimal](10, 5) NULL,
	[Longitude] [decimal](10, 5) NULL,
	[ReportID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ObservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[Subtotal]  AS ([Quantity]*[UnitCost]),
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateShipped] [datetime2](7) NULL,
	[Verified] [bit] NOT NULL,
	[Completed] [bit] NOT NULL,
	[Canceled] [bit] NOT NULL,
	[Comments] [nchar](100) NULL,
	[ShippingAddress] [nvarchar](50) NULL,
	[Status] [int] NOT NULL,
	[Reference] [nvarchar](50) NULL,
	[AuthCode] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Price] [money] NOT NULL,
	[Thumbnail] [nvarchar](50) NULL,
	[Image] [nvarchar](50) NULL,
	[PromoFront] [bit] NOT NULL,
	[PromoDept] [bit] NOT NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [pk_product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ProductID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ProjectID] [int] IDENTITY(500,1) NOT NULL,
	[ProjectName] [nvarchar](255) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[Coordinator] [int] NULL,
	[Description] [nvarchar](1000) NULL,
	[ResearchID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reports]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reports](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectID] [int] NULL,
	[ReportDate] [datetime2](7) NULL,
	[VolunteerID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResearchAreas]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResearchAreas](
	[ResearchID] [int] IDENTITY(100,1) NOT NULL,
	[ResearchName] [nvarchar](255) NOT NULL,
	[InstitutionID] [int] NULL,
	[Description] [nvarchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ResearchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[CartID] [char](36) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Attributes] [nvarchar](1000) NULL,
	[Quantity] [int] NOT NULL,
	[DateAdded] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Volunteers]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Volunteers](
	[VolunteerID] [int] IDENTITY(400,1) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[ContactNumber] [nvarchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VolunteerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Verified]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Completed]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Canceled]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ('GenericThumb.png') FOR [Thumbnail]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ('GenericImage.png') FOR [Image]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [PromoFront]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [PromoDept]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [fk_category_department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [fk_category_department]
GO
ALTER TABLE [dbo].[Observations]  WITH CHECK ADD  CONSTRAINT [FK_Observations_DataCollectionTools] FOREIGN KEY([ToolID])
REFERENCES [dbo].[DataCollectionTools] ([ToolID])
GO
ALTER TABLE [dbo].[Observations] CHECK CONSTRAINT [FK_Observations_DataCollectionTools]
GO
ALTER TABLE [dbo].[Observations]  WITH CHECK ADD  CONSTRAINT [FK_Observations_Reports] FOREIGN KEY([ReportID])
REFERENCES [dbo].[Reports] ([ReportID])
GO
ALTER TABLE [dbo].[Observations] CHECK CONSTRAINT [FK_Observations_Reports]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [fk_OrderDetail_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [fk_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Category]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Product]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ResearchAreas] FOREIGN KEY([ResearchID])
REFERENCES [dbo].[ResearchAreas] ([ResearchID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ResearchAreas]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_Volunteers] FOREIGN KEY([Coordinator])
REFERENCES [dbo].[Volunteers] ([VolunteerID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_Volunteers]
GO
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ProjectID])
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_Projects]
GO
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_Volunteers] FOREIGN KEY([VolunteerID])
REFERENCES [dbo].[Volunteers] ([VolunteerID])
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_Volunteers]
GO
ALTER TABLE [dbo].[ResearchAreas]  WITH CHECK ADD  CONSTRAINT [FK_ResearchAreas_Institutions] FOREIGN KEY([InstitutionID])
REFERENCES [dbo].[Institutions] ([InstitutionID])
GO
ALTER TABLE [dbo].[ResearchAreas] CHECK CONSTRAINT [FK_ResearchAreas_Institutions]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Product]
GO
/****** Object:  StoredProcedure [dbo].[spAddUserInfoToDB]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--16 
CREATE PROCEDURE [dbo].[spAddUserInfoToDB] @CustomerID CHAR(36), @Username NVARCHAR(50)
AS
BEGIN
    INSERT INTO [dbo].[Customers](CustomerID, Username)
    VALUES(@CustomerID, @Username);
END
GO
/****** Object:  StoredProcedure [dbo].[spCountProductsWithPriceGreaterThanValue]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ChatGPT did not set 12.99 as a default value, so we will do that now.
CREATE PROCEDURE [dbo].[spCountProductsWithPriceGreaterThanValue] 
@price MONEY = 12.99, @count INT OUTPUT -- no default
AS
BEGIN
    SELECT @count = COUNT(*)
    FROM [dbo].[Product]
    WHERE Price >= @price;
END
GO
/****** Object:  StoredProcedure [dbo].[spCreateCustomerOrder]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--15
-- ChatGPT Really struggled with this one.
CREATE PROCEDURE [dbo].[spCreateCustomerOrder] @CartID CHAR(36), @CustomerID CHAR(36), @OrderID INT OUTPUT
AS
BEGIN
    BEGIN TRANSACTION; -- Use transaction in case something messes up
        -- Create a new order
        INSERT INTO [dbo].[Orders](CustomerID, DateCreated, Completed, Canceled, Verified,Status)
        VALUES(@CustomerID, GETDATE(),0,0,0,0);

        SET @OrderID = @@IDENTITY; -- ChatGPT used different identity handling than we are used to

        -- Transfer items from cart to orderdetail
        INSERT INTO [dbo].[OrderDetail](OrderID, ProductID, ProductName, Quantity, UnitCost)
        SELECT @OrderID, p.ProductID, p.Name, s.Quantity, Price
        FROM [dbo].[ShoppingCart] s
        inner join Product p
            on p.ProductID = s.ProductID
        WHERE CartID = @CartID;

        -- Empty the cart
        DELETE FROM [dbo].[ShoppingCart]
        WHERE CartID = @CartID;
	COMMIT TRANSACTION;
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllCategories]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[spGetAllCategories]
	AS
	select * from Category
GO
/****** Object:  StoredProcedure [dbo].[spGetCategoriesByName]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spGetCategoriesByName]
@Name nvarchar(50)
AS
select * from Category
where Name like '%' + @Name + '%'
GO
/****** Object:  StoredProcedure [dbo].[spGetCategoriesInDepartment]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spGetCategoriesInDepartment]
@DepartmentID int
AS
select * from Category
where DepartmentID=@DepartmentID
GO
/****** Object:  StoredProcedure [dbo].[spGetCategoriesInDepartmentOptional]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spGetCategoriesInDepartmentOptional]
@DepartmentID int = null
AS
select * from Category
where DepartmentID=@DepartmentID
GO
/****** Object:  StoredProcedure [dbo].[spGetCategoryBetweenIDsOptional]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetCategoryBetweenIDsOptional]
@CategoryID1 int = null, @CategoryID2 int = null
AS
select * from Category
where CategoryID >= isnull(@CategoryID1,CategoryID) and CategoryID<=isnull(@CategoryID2,CategoryID)
GO
/****** Object:  StoredProcedure [dbo].[spGetProductsinCategory]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[spGetProductsinCategory] 
@CategoryID int
AS
	SELECT [ProductID]
      ,[Name]
      ,left([Description], 60)
      ,[Price]
      ,[Thumbnail]
      ,[Image]
      ,[PromoFront]
      ,[PromoDept]
	FROM Product
	WHERE ProductID in (select ProductID from ProductCategory where CategoryID=@CategoryID)
GO
/****** Object:  StoredProcedure [dbo].[spGetProductsOnDeptPromo]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spGetProductsOnDeptPromo]
@MaxLength int = 60
AS
	SELECT [ProductID]
      ,[Name]
      ,left([Description], @MaxLength ) as DescriptionTrunc
      ,[Price]
      ,[Thumbnail]
      ,[Image]
      ,[PromoFront]
      ,[PromoDept]
	FROM Product
	WHERE PromoDept = 1
GO
/****** Object:  StoredProcedure [dbo].[spShoppingCartAddItem]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 10
CREATE PROCEDURE [dbo].[spShoppingCartAddItem] 
@CartID CHAR(36), @ProductID INT, @Attributes NVARCHAR(1000) = null -- add default
AS
BEGIN
    INSERT INTO [dbo].[ShoppingCart](CartID, ProductID, Attributes, Quantity, DateAdded)
    VALUES(@CartID, @ProductID, @Attributes, 1, GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[spShoppingCartAddorUpdateItem]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Then, we can use it in our stored procedure.
CREATE PROCEDURE [dbo].[spShoppingCartAddorUpdateItem] 
@CartID CHAR(36), @ProductID INT, @Attributes NVARCHAR(1000) = null -- add default
AS
BEGIN
    declare @NewQuantity int
    set @NewQuantity = dbo.GetCartQuantity(@CartID, @ProductID) + 1
    if @NewQuantity = 1 -- same as if quantity = 0
        exec spShoppingCartAddItem @CartID, @ProductID, @Attributes -- note that we can use another stored procedure in a stored procedure
    else
        exec spShoppingCartUpdateItem @CartID, @ProductID, @NewQuantity
END
GO
/****** Object:  StoredProcedure [dbo].[spShoppingCartGetItems]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--13
CREATE PROCEDURE [dbo].[spShoppingCartGetItems] @CartID CHAR(36)
AS
BEGIN
    SELECT ProductID, Attributes, Quantity, DateAdded
    FROM [dbo].[ShoppingCart]
    WHERE CartID = @CartID;
END
GO
/****** Object:  StoredProcedure [dbo].[spShoppingCartGetTotalAmount]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--14
CREATE PROCEDURE [dbo].[spShoppingCartGetTotalAmount] @CartID CHAR(36), @TotalAmount MONEY OUTPUT
AS
BEGIN
    SELECT @TotalAmount = SUM(p.Price * s.Quantity)
    FROM [dbo].[ShoppingCart] s
    Inner JOIN [dbo].[Product] p 
		ON s.ProductID = p.ProductID -- no join default
    WHERE s.CartID = @CartID;
END
GO
/****** Object:  StoredProcedure [dbo].[spShoppingCartRemoveItem]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--11
CREATE PROCEDURE [dbo].[spShoppingCartRemoveItem] @CartID CHAR(36), @ProductID INT
AS
BEGIN
    DELETE FROM [dbo].[ShoppingCart]
    WHERE CartID = @CartID AND ProductID = @ProductID;
END
GO
/****** Object:  StoredProcedure [dbo].[spShoppingCartUpdateItem]    Script Date: 10/17/2023 9:25:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--12
CREATE PROCEDURE [dbo].[spShoppingCartUpdateItem] @CartID CHAR(36), @ProductID INT, @Quantity INT
AS
BEGIN
    UPDATE [dbo].[ShoppingCart]
    SET Quantity = @Quantity
    WHERE CartID = @CartID AND ProductID = @ProductID;
END
GO
USE [master]
GO
ALTER DATABASE [SportsStoreDB] SET  READ_WRITE 
GO
