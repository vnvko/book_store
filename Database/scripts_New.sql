USE [master]
GO
/****** Object:  Database [menfashion]    Script Date: 28/11/2023 9:13:41 PM ******/
CREATE DATABASE [menfashion]

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [menfashion].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [menfashion] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [menfashion] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [menfashion] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [menfashion] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [menfashion] SET ARITHABORT OFF 
GO
ALTER DATABASE [menfashion] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [menfashion] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [menfashion] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [menfashion] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [menfashion] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [menfashion] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [menfashion] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [menfashion] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [menfashion] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [menfashion] SET  DISABLE_BROKER 
GO
ALTER DATABASE [menfashion] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [menfashion] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [menfashion] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [menfashion] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [menfashion] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [menfashion] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [menfashion] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [menfashion] SET RECOVERY FULL 
GO
ALTER DATABASE [menfashion] SET  MULTI_USER 
GO
ALTER DATABASE [menfashion] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [menfashion] SET DB_CHAINING OFF 
GO
ALTER DATABASE [menfashion] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [menfashion] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [menfashion] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [menfashion] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'menfashion', N'ON'
GO
ALTER DATABASE [menfashion] SET QUERY_STORE = OFF
GO
USE [menfashion]
GO
/****** Object:  User [doancoso]    Script Date: 28/11/2023 9:13:41 PM ******/
CREATE USER [doancoso] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [doancoso]
GO
/****** Object:  Table [dbo].[Invoince]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoince](
	[invoinceNo] [varchar](50) NOT NULL,	/*[hóa đơnKhông]*/
	[dateOrder] [datetime] NULL,	/*[ngày đặt hàng]*/ 
	[status] [bit] NULL,	/*[trạng thái]*/
	[deliveryStatus] [bit] NULL,	/*[Trạng thái giao hàng]*/
	[deliveryDate] [datetime] NULL,		/*[ngày giao hàng]*/
	[totalMoney] [int] NOT NULL,	/*[Tổng số tiền]*/
	[userName] [varchar](50) NULL,	/*[tên tài khoản]*/
	[customerId] [int] NULL,	/*[ID khách hàng]*/
PRIMARY KEY CLUSTERED 
(
	[invoinceNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vDoanhThuTheoNgay]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDoanhThuTheoNgay] AS
SELECT ISNULL(CONVERT(VARCHAR(10), dateOrder, 103),-1) AS dateOrder, sum(totalMoney) AS income
FROM dbo.Invoince hd 
GROUP BY CONVERT(VARCHAR(10), dateOrder, 103)
GO
/****** Object:  View [dbo].[vHoaDonTrongNgay]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vHoaDonTrongNgay] AS
select *
from dbo.Invoince
where DATEPART(day,dateOrder) = DATEPART(day,getdate())
GO
/****** Object:  Table [dbo].[Article]    Script Date:28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](					/*[Bài báo]*/
	[articleId] [int] IDENTITY(1,1) NOT NULL,	/*[ID bài viết]*/
	[title] [nvarchar](250) NOT NULL,			/*[tiêu đề]*/
	[shortDescription] [nvarchar](2000) NULL,	/*[Mô tả ngắn]*/
	[image] [nvarchar](2000) NULL,				/*[hình ảnh]*/
	[publicDate] [datetime] NULL,				/*[ngày công khai]*/
	[content] [nvarchar](max) NULL,				/*[nội dung]*/
	[status] [bit] NULL,						/*[trạng thái]*/
	[userName] [varchar](50) NOT NULL,				/*[tên tài khoản]*/
	[categoryId] [int] NOT NULL,			/*[Thể loại ID]*/
PRIMARY KEY CLUSTERED 
(
	[articleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](					/*[Liên hệ]*/
	[id] [int] IDENTITY(1,1) NOT NULL,			/*[nhận dạng]*/
	[dateContact] [datetime] NULL,			/*[ngàyLiên hệ]*/
	[name] [nvarchar](250) NULL,			/*tên*/
	[email] [varchar](50) NOT NULL,			/*email*/
	[message] [nvarchar](2000) NULL,		/*tin nhắn*/
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](						/*[Khách hàng]*/
	[customerId] [int] IDENTITY(1,1) NOT NULL,		/*id khách hàng*/
	[firstName] [nvarchar](250) NULL,		/*[tên đầu tiên]*/
	[lastName] [nvarchar](250) NOT NULL,		/*[lastName]*/
	[email] [varchar](50) NOT NULL,			/*mail*/
	[phone] [varchar](20) NULL,			/*phone*/
	[address] [nvarchar](250) NULL,		/*địa chỉ*/
PRIMARY KEY CLUSTERED 
(
	[customerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoinceDetail]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoinceDetail](			/*[Chi tiết hóa đơn]*/
	[invoinceNo] [varchar](50) NOT NULL,		/*[hóa đơn không có]*/
	[productId] [int] NOT NULL,		/*[Id sản phẩm]*/
	[quanlityProduct] [int] NULL,		/*[sản phẩm chất lượng]*/
	[unitPrice] [int] NULL,		/*[đơn giá]*/
	[totalPrice] [int] NULL,		/*[Tổng giá]*/
	[totalDiscount] [int] NULL,		/*[Tổng khấu trừ]*/
PRIMARY KEY CLUSTERED		
(
	[invoinceNo] ASC,
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](			/*[Thành viên]*/
	[userName] [varchar](50) NOT NULL,	/*[tên tài khoản]*/
	[password] [varchar](50) NOT NULL,		/*mật khẩu*/
	[firstName] [nvarchar](250) NULL,		/*tên đầu*/
	[lastName] [nvarchar](250) NULL,		/*họ*/
	[email] [varchar](50) NULL,		/*mail*/
	[birthday] [date] NULL,		/*ngày sinh*/
	[identityNumber] [varchar](20) NULL,		/*[số nhận dạng]*/
	[phone] [varchar](20) NULL,		/*đt*/
	[dateOfJoin] [datetime] NULL,		/*[ngày tham gia]*/
	[address] [nvarchar](250) NULL,		/*địa chỉ*/
	[avatar] [nvarchar](2000) NULL,		/*[hình đại diện]*/
	[status] [bit] NULL,	/*trạng thái*/
	[roleId] [int] NOT NULL,	/*[Id vai trò]*/
PRIMARY KEY CLUSTERED 
(
	[userName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](		/*[Sản phẩm]*/
	[productId] [int] IDENTITY(1,1) NOT NULL,		/*[ID sản phẩm]*/
	[productName] [nvarchar](250) NOT NULL,/*[tên sản phẩm]*/
	[image] [varchar](2000) NULL,/*[hình ảnh]*/
	[price] [int] NULL,/*[giá]*/
	[discount] [int] NULL,/*[giảm giá]*/
	[description] [nvarchar](2000) NULL,/*[Sự miêu tả]*/
	[quanlity] [int] NULL,/*[chất lượng]*/
	[brand] [nvarchar](250) NULL,/*[thương hiệu]*/
	[dateCreate] [datetime] NULL,/*[ngàyTạo]*/
	[status] [bit] NULL,/*[trạng thái]*/
	[categoryId] [int] NOT NULL,/*[Thể loại ID]*/
	[userName] [varchar](50) NOT NULL,/*[[tên tài khoản]*/
PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory]( /*[Danh mục sản phẩm]*/
	[categoryId] [int] IDENTITY(1,1) NOT NULL, /*[Thể loại ID]*/
	[categoryName] [nvarchar](250) NOT NULL,/*[tên danh mục]*/
PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](	/*[Vai trò]*/
	[roleId] [int] IDENTITY(1,1) NOT NULL, /*id vai trò*/
	[roleName] [nvarchar](50) NOT NULL, /*tên vai trò*/
PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slide]    Script Date: 28/11/2023 9:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slide](
	[id] [int] IDENTITY(1,1) NOT NULL,	/*id*/
	[dateCreate] [datetime] NULL,  /*ngày tạo*/
	[name] [nvarchar](50) NULL,/*tên*/
	[description] [nvarchar](250) NULL,/*miêu tả*/
	[url] [varchar](50) NULL,/*đường dẫn*/
	[status] [bit] NULL,  /*trạng thái*/
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Article] ON /*[Bài báo]*/

INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [image], [publicDate], [content], [status], [userName], [categoryId]) VALUES (1, N'Summer Shirting: The Complete Short Sleeve Button Up Guide', N'', N'~/Content/img/blog/Short-sleeve-shirt-1160x677.jpg', CAST(N'2021-08-15T22:33:25.787' AS DateTime), N'For all its benefits, summer can be a tricky season to dress for. Not in terms of effort – after all, what could be easier than throwing on a pair of shorts and a top? – more that it can be difficult to get creative when limited to such a small selection of garments.Winter brings with it an abundance of sartorial avenues for exploration. We can layer, experiment with textures and use outerwear to our advantage. In summer the options are far fewer. But there is one handy tool you have at your disposal, provided you know how to use it to full effect.This summery take on the classic button-up is a style-conscious man’s best friend in the warmer months. It can lend a dressier edge to otherwise sloppy poolside ensembles, spice up uninspired outfits via appealing colours and eye-catching patterns, and is one of the few garments through which it’s acceptable to convey a little touch of humour and irony. All-over tropical island print? Don’t mind if we do.', 1, N'admin', 2)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [image], [publicDate], [content], [status], [userName], [categoryId]) VALUES (2, N'High-Fashion Scents: The Greatest Designer Fragrances Of All Time', N'', N'~/Content/img/blog/designer-fragrances-2-1160x677.jpg', CAST(N'2021-08-15T22:33:25.787' AS DateTime), N'Eau de Cologne – the style and type of concentration – was invented by Johann Maria Farina in 1709, while synthetic ingredients have been commonly used since the late 18th Century. And designer scents? “The men’s fashion market was born in the late 1950s, with the iconic launch of Monsieur de Givenchy,” says perfumer Azzi Glasser, founder of The Perfumer’s Story. “Brut by Fabergé (1968) brought in the famous fougère accord, which established the character for men’s fragrances and the start of many others,” says Glasser, who has created fragrances for Topman, Agent Provocateur and Bella Freud, and bespoke scents for many Hollywood actors.', 1, N'admin', 7)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [image], [publicDate], [content], [status], [userName], [categoryId]) VALUES (4, N'Low-Tech Kicks: Why The Humble Tennis Shoe Will Always Be In Fashion', N'', N'~/Content/img/blog/Adidas-Stan-Smith-1160x677.jpg', CAST(N'2021-08-15T22:33:25.790' AS DateTime), N'One hundred and twenty years ago this year, one Charles Taylor was born. Taylor, a one-time basketball player, had been a shoe salesman for most of his life. And yet his legacy was to establish a multi-billion dollar industry. During the 1930s, in one of the earliest instances of celebrity sponsorship, Charles, better known as ‘Chuck’, lent his name to a minimalistic high-top basketball boot that had been launched in 1917. And the result – the Chuck Taylor All-Star – was arguably the first classic, must-have sneaker.', 1, N'admin', 6)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [image], [publicDate], [content], [status], [userName], [categoryId]) VALUES (5, N'Fashion Forward: The Menswear Trends To Know For Fall/Winter 2021', NULL, N'~/Content/img/blog/Menswear-trends-autumn-winter-2021-1160x677.jpg', CAST(N'2021-09-15T16:16:10.197' AS DateTime), N'<p>There&rsquo;s a common misconception that religiously adhering to trends equates to&nbsp;<a href="https://www.apetogentleman.com/how-to-dress-well-rules/" data-wpel-link="internal">good dressing</a>. In our humble opinion, this is not the case. Blindly following each and every seasonal trend is a recipe for poor style. Not to mention an easy way to bankrupt yourself.</p>
<p>The key to retaining your sartorial self-respect lies in the ability to successfully differentiate between the fleeting fads and the future classics. And in order to give you a nudge in the right direction, we&rsquo;ve created a carefully selected edit of the menswear movements worth incorporating into your wardrobe this year.</p>
<p>From the return of florals to the continued widening of silhouettes, these are the men&rsquo;s fashion trends to embrace in 2021.</p>
<h2>WFH Cosiness</h2>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2021/09/119564730_1891739017632787_6994662396377016206_n-1160x769.jpg" /></p>
<p>It&rsquo;s impossible to say where we&rsquo;ll be 10 months from now but chances are there&rsquo;ll still be fluctuating coronavirus restrictions around the world. For that reason,&nbsp;<a href="https://www.apetogentleman.com/best-mens-loungewear-brands/" data-wpel-link="internal">luxe loungewear</a>&nbsp;and house shoes are likely to be trending hard.</p>
<p>Think socks &amp; &lsquo;stocks, hoodies, slouchy overshirts, drawstring pants and loose-fitting tees. The kind of clothing that borders on pyjama levels of comfort but that won&rsquo;t get you sacked if you have to attend an impromptu Zoom call with your boss.</p>
<h2>Fleece</h2>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2020/01/fleece.jpg" /></p>
<p>The revival of fleece is symptomatic of the broader trend in menswear towards outdoors-inspired garb. Thick-pile retro fleeces have been popular as standalone outerwear for several seasons now, while designers continue to work more and more of the fabric into their autumn/winter collections.</p>
<p>This trend is best served in small portions. Keep it to one fleece garment per outfit to avoid going full sheep and mix and match it with other textured fabrics to add another tactile dimension to your cold-weather looks.</p>', 1, N'admin', 3)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [image], [publicDate], [content], [status], [userName], [categoryId]) VALUES (6, N'Perfect Pairings: What Shoes To Wear With Jeans', NULL, N'~/Content/img/blog/what-shoes-with-jeans-1-1160x676.jpg', CAST(N'2021-09-15T16:25:22.310' AS DateTime), N'<p>Jeans have been the world&rsquo;s favourite legwear for just shy of 100 years. Why? Probably because they&rsquo;re famously durable,&nbsp;<a href="https://www.apetogentleman.com/what-to-wear-denim-jeans-colours/" data-wpel-link="internal">easy to wear</a>&nbsp;and versatile to the extreme. But while they&rsquo;re generally straightforward to style, there are certain pairing guidelines to follow if you want&nbsp;<a href="https://www.apetogentleman.com/best-denim-jeans-brands-men/" data-wpel-link="internal">your jeans to look their best</a>&hellip; particularly when it comes to footwear.</p>
<p>So what shoes should you wear with your jeans? It&rsquo;s a question that every style-conscious man has asked himself at some point. As versatile as jeans are, there are certain&nbsp;<a href="https://www.apetogentleman.com/types-of-shoes/" data-wpel-link="internal">types of shoes</a>&nbsp;that will never look good with&nbsp;<a href="https://www.apetogentleman.com/what-to-wear-denim-jeans-colours/" data-wpel-link="internal">specific shades of denim</a>, and others that will look great every time.</p>
<p>The key to nailing it is knowing what those shades and styles are. So, to help you get it right, we&rsquo;ve prepared a handy cheat sheet, highlighting five key denim shades and the types of footwear that work best with each one.</p>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2020/12/howtowearleather5.jpg" /></p>
<p>Jeans don&rsquo;t typically work well in smart settings &ndash; unless they&rsquo;re black, that is. A&nbsp;<a href="https://www.apetogentleman.com/what-to-wear-black-jeans-men/" data-wpel-link="internal">pair of black jeans</a>&nbsp;is sharp, subtle and perfect for occasions that call for clothing on the dressier end of the&nbsp;<a href="https://www.apetogentleman.com/smart-casual/" data-wpel-link="internal">smart-casual spectrum</a>, such as dates, upmarket restaurants and bars, and nights out.</p>
<p>To make the most of their aesthetic benefits, you&rsquo;ll want to make sure you choose your shoes carefully. As a rule of thumb, it&rsquo;s best to stick to dark colours &ndash; you&rsquo;re aiming for subtle, not jarring. Colours like burgundy, dark brown, dark green and, of course, black, will all work nicely. An exception to this rule is&nbsp;<a href="https://www.apetogentleman.com/best-white-sneakers-men/" data-wpel-link="internal">white minimalist sneakers</a>, which will always perfectly complement slim-cut black jeans.</p>
<p>Keep the style of shoe relatively smart too. Think&nbsp;<a href="https://www.apetogentleman.com/best-chelsea-boots-men/" data-wpel-link="internal">Chelsea boots</a>,&nbsp;<a href="https://www.apetogentleman.com/best-chukka-desert-boots/" data-wpel-link="internal">desert boots</a>,&nbsp;<a href="https://www.apetogentleman.com/best-luxury-sneaker-brands/" data-wpel-link="internal">luxe sneakers</a>&nbsp;and Derby shoes. A nice&nbsp;<a href="https://www.apetogentleman.com/best-loafers-men/" data-wpel-link="internal">loafer</a>&nbsp;or deck shoe will work well in the warmer months too.</p>
<h2>What Shoes To Wear With Dark Jeans</h2>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2021/09/shoeswithjeansraw3.jpg" /></p>
<p>A pair of proper&nbsp;<a href="https://www.apetogentleman.com/best-raw-selvedge-denim-jeans/" data-wpel-link="internal">raw-denim jeans</a>&nbsp;is something that every&nbsp;<a href="https://www.apetogentleman.com/how-to-dress-well-rules/" data-wpel-link="internal">well-dressed man</a>&nbsp;should have hanging proudly in his wardrobe. This is denim in its purest form: heavy, unwashed and rugged. It&rsquo;s most at home with casual, smart-casual and&nbsp;<a href="https://www.apetogentleman.com/best-workwear-brands/" data-wpel-link="internal">workwear-based garments</a>&nbsp;and that extends to the footwear it should be paired with it too.</p>
<p>Raw denim is dark, so you should approach colour matching your shoes much the same as you would with black jeans. We&rsquo;re talking dark colours &ndash; black, brown, burgundy, etc &ndash; with the notable exception of sneakers, where there&rsquo;s a little more room for manoeuvre. Just steer clear of navy and very light browns, like tan, and you won&rsquo;t go far wrong.</p>
<p>With the exception of true dress shoes, like Oxfords, there aren&rsquo;t many shoes that won&rsquo;t pair well with raw jeans. That said,&nbsp;<a href="https://www.apetogentleman.com/how-to-wear-boots-with-jeans-men/" data-wpel-link="internal">boots always work well</a>&nbsp;as they fit in with raw denim&rsquo;s workwear roots &ndash; think moc-toe boots, chukka and&nbsp;<a href="https://www.apetogentleman.com/best-designer-hiking-boots-men/" data-wpel-link="internal">hiking boots</a>&nbsp;in either suede or leather.</p>
<div id="apeto-134f3a6c62176f358e8227e7a8007366" class="apeto-134f3a6c62176f358e8227e7a8007366 apeto-in-content-ads">
<div id="apeto-1674110262" class="apeto-in-content-ads"></div>
</div>
<div id="apeto-73ae5f3ba78997263c8fb6c9bc99cda8" class="apeto-73ae5f3ba78997263c8fb6c9bc99cda8 apeto-in-content-ad-after-intro">
<div id="apeto-948093548" class="apeto-in-content-ad-after-intro"></div>
</div>', 1, N'ntdung8124', 5)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [image], [publicDate], [content], [status], [userName], [categoryId]) VALUES (7, N'Blue-Collar Style: A Modern Man’s Guide To Denim Shirts', NULL, N'~/Content/img/blog/best-denim-shirts-men-1160x677.jpg', CAST(N'2021-09-15T16:27:36.303' AS DateTime), N'<p>The denim shirt: one of menswear&rsquo;s true unsung heroes. This wardrobe workhorse lives in the shadow of so-called essentials like the&nbsp;<a href="https://www.apetogentleman.com/oxford-cloth-button-down-shirt/" data-wpel-link="internal">OCBD</a>&nbsp;and the&nbsp;<a href="https://www.apetogentleman.com/best-flannel-shirts-men/" data-wpel-link="internal">flannel shirt</a>, but it&rsquo;s every bit as versatile, easy to wear and functional. We&rsquo;d argue, even more so in some ways.</p>
<p>What we have here is a genuine workwear staple; a garment that&rsquo;s been there from the very beginning and remained steadfast throughout. From the workshops of 19th century America to the runway, the denim shirt has risen through the ranks, unfaltering along the way. Today, it&rsquo;s status as a must-have garment for the modern man is cemented and if you don&rsquo;t already count one among&nbsp;<a href="https://www.apetogentleman.com/types-of-shirt/" data-wpel-link="internal">your shirt selection</a>, well, what are you waiting for?</p>
<p>Here we take a look at some key considerations to make when shopping for your new denim shirt, along with some foolproof styling tips and our hand-picked list of the brands that do it best.</p>
<h2>Denim Shirt Buying Considerations</h2>
<p>There are a few things to think about in order to find the denim shirt that&rsquo;s best for you. From how it fits to where it&rsquo;s made, these are the key buying considerations every shopper should make before parting with their cash.</p>
<h3>Fit</h3>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2021/08/denimshirtbrandsproductslb3.jpg" /></p>
<p>Fit matters. In fact, it&rsquo;s probably the single most important thing about any given article of clothing. It doesn&rsquo;t matter how expensive or well made a garment is, if it doesn&rsquo;t fit, you&rsquo;ll still look badly dressed.</p>
<p>It can be a subjective thing, though. For example, you may be deliberately looking for a slouchy, oversized fit, which is fine. However, to play it safe and keep things classic, you should always be aiming for seams that sit neatly on the shoulders, a hem that falls a few inches south of your beltline and a body that is slim without being in any way tight or restrictive.</p>
<h3>Style</h3>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2021/08/denimshirtbrandsproductslb2.jpg" /></p>
<p>There are many different denim shirts out there, but most of them can be lumped into one of two distinct categories: western and classic button-down. Western shirts tend to feature accentuated, pointed yokes and dual chest pockets with snap openings. They sometimes (although less commonly) feature embellishments such as embroidery or fringes too.</p>
<p>The classic button-down style of denim shirt, on the other hand, is much like a simple OCBD, the key difference being that it&rsquo;s made of denim as opposed to Oxford cloth.</p>
<h3>Colour</h3>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2021/08/denimshirtbrandsproductslb.jpg" /></p>
<p>Denim shirts come in a fairly limited palette. Outside of black and various shades of grey and blue, there&rsquo;s really not a lot of choice. Which colour you eventually end up with will obviously be largely down to personal preference, but we&rsquo;d suggest sticking to a mid- to light-wash blue for a combination of classic looks and versatility. A darker, unwashed indigo can work well too &ndash; particularly for smart-casual looks.</p>
<div id="apeto-23ddafc0929b75a1a2424fc5d55035b9" class="apeto-23ddafc0929b75a1a2424fc5d55035b9 apeto-in-content-ads">
<div id="apeto-1766863416" class="apeto-in-content-ads"></div>
</div>
<div id="apeto-f38e80c2814adaf7dc945a7acfdf707a" class="apeto-f38e80c2814adaf7dc945a7acfdf707a apeto-in-content-ad-after-intro">
<div id="apeto-1031536189" class="apeto-in-content-ad-after-intro"></div>
</div>', 1, N'ntdung8124', 2)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [image], [publicDate], [content], [status], [userName], [categoryId]) VALUES (8, N'9 Gym Shoes That Will Take Your Workouts To The Next Level', NULL, N'~/Content/img/blog/Nike-Metcon-7-1160x677.jpg', CAST(N'2021-09-15T16:30:15.957' AS DateTime), N'<p>Not all&nbsp;<a href="https://www.apetogentleman.com/best-sneaker-brands/" data-wpel-link="internal">sneakers</a>&nbsp;are born equal. That goes for your casual kicks as much as it does for the average workout shoe. With moon landing levels of tech being integrated into ever-more impressive trainers, it&rsquo;s difficult to sort through the gimmicks and the foam soles.</p>
<p>But worry not, we desire that perfect athletic body as much as the next man &ndash; and we&rsquo;re here to guide you through the best possible footwear to achieve your goals, whether it&rsquo;s lifting personal bests, sweating through HIIT workouts or tearing up a CrossFit circuit.</p>
<h2>Purchasing Considerations</h2>
<p>Before parting with your hard-earned cash, you should consider a couple of things. Firstly, like with clothing, fit is king. You&rsquo;re not going to get the most out of your workout if you&rsquo;re wearing a shoe that doesn&rsquo;t fit properly.</p>
<p>Shoe sizes that work in different corridors of your life might not be appropriate in the workout or lifting arena. For example, if you&rsquo;re lifting heavy weight you&rsquo;ll want a wider shoe to ensure a more stable base and help transfer power. Likewise, you don&rsquo;t want to do CrossFit in a shoe that is too small and doesn&rsquo;t allow manoeuvrability, or pound out cardio in sneakers that aren&rsquo;t supremely comfortable and light.</p>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2021/08/gym-shoes.jpg" /></p>
<p>Secondly, you may need different shoes for different activities. There are sneakers on this list that are specifically for weightlifting sessions &ndash; wide bases, stiffer materials and ankle support built in as well as a tell-tale toe strap are the giveaways. There&rsquo;s also all-rounders, with support in the mid-sole and added cushioning for extended periods of movement. Lighter shoes, meanwhile, will allow for better bursts of explosive power in HIIT workouts. If you like to mix up your workouts, we&rsquo;d recommend having a rotation of shoes that can be called on.</p>
<p>With that in mind here&rsquo;s our selection of the best gym trainers with options for different workouts, styles and budgets.</p>
<h2>Nike Metcon 7</h2>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2021/08/gymtrainersone.jpg" /></p>
<p>The latest iteration of a classic, Nike&rsquo;s Metcon 7 is a great-looking sneaker. The tech and CrossFit input into this model is astounding and includes integrated heel support to stabilise the force on different areas of the shoe when lifting, an inner plate that spreads the weight from edge to edge, rubber added to the sides for more traction on rope climbs, react foam for comfort and added spring on sprints, as well as a tab that locks down your laces so you don&rsquo;t ever have to worry about them coming untied.</p>
<p>Stiffness and lightness come as standard, with neither sacrificed for the other. A true all-rounder.</p>
<h2>On Cloud X</h2>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2021/08/gymtrainers2.jpg" /></p>
<p>Whilst On is very much a&nbsp;<a href="https://www.apetogentleman.com/best-running-shoes-brands/" data-wpel-link="internal">running shoe brand</a>, with the Swiss company managing to break into an arena that was previously reserved for&nbsp;<a href="https://www.apetogentleman.com/best-sportswear-brands/" data-wpel-link="internal">sportswear giants</a>, the Cloud X is a sneaker that can hold its own across the gym floor.</p>
<p>Cloudtec soles keep things comfortably bouncy when you need to dig in and keep bursting forward, while the dual-density sock liner and knit-weave upper both work together to ensure comfort and wick away sweat. They&rsquo;re also extremely light without feeling like they&rsquo;re going to fall apart.</p>
<h2>Reebok Nano X1 Adventure</h2>
<p><img src="https://www.apetogentleman.com/wp-content/uploads/2021/08/gymtrainers3.jpg" /></p>
<p>Sturdy and robust without feeling like every step is a rep, Reebok&rsquo;s Nano X1 Adventure sneakers are for those who prefer their workouts outdoors.</p>
<p>Engineered to be used on differing terrain &ndash; be it concrete, grass or even sand &ndash; the sole is reinforced and features raised lugs for extra grip while the Floatride Energy Foam ensures comfort over long periods and a responsive feel that is imperative when dealing with uneven surfaces.</p>
<div id="apeto-3c6c6fe54e0f39d7e2d7826fc35af6ef" class="apeto-3c6c6fe54e0f39d7e2d7826fc35af6ef apeto-in-content-ad-after-intro">
<div id="apeto-14415451" class="apeto-in-content-ad-after-intro"></div>
</div>', 1, N'admin', 6)
INSERT [dbo].[Article] ([articleId], [title], [shortDescription], [image], [publicDate], [content], [status], [userName], [categoryId]) VALUES (9, N'The Best Luxury Smartwatches A Tech-Loving Collector Can Ownxx', NULL, N'~/Content/img/blog/Montblanc-Summit-2-1160x677.jpg', CAST(N'2021-09-15T16:32:44.000' AS DateTime), N'', 1, N'admin', 7)
SET IDENTITY_INSERT [dbo].[Article] OFF
GO
SET IDENTITY_INSERT [dbo].[Contact] ON		/*[Liên hệ]*/

INSERT [dbo].[Contact] ([id], [dateContact], [name], [email], [message]) VALUES (3, CAST(N'2023-06-10T11:25:02.113' AS DateTime), N'abcd', N'democodedoan@gmail.com', N'xin chao ')
INSERT [dbo].[Contact] ([id], [dateContact], [name], [email], [message]) VALUES (4, CAST(N'2023-06-10T11:39:59.177' AS DateTime), N'xvc', N'abcd@gmail.com', N'hello')
SET IDENTITY_INSERT [dbo].[Contact] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON		/*[Khách hàng]*/

INSERT [dbo].[Customer] ([customerId], [firstName], [lastName], [email], [phone], [address]) VALUES (1, N'Nguyễn Văn', N'Minh', N'minh@gmail.com', N'0943658092', N'Bưu điện khu công nghiệp Biên Hòa 2 Phường An Bình Thành Phố Biên Hòa Đồng Nai')
INSERT [dbo].[Customer] ([customerId], [firstName], [lastName], [email], [phone], [address]) VALUES (3, N'Trần Trung', N'Hiếu', N'hieu@gmail.com', N'012321413123', N'78 Trần Hưng Đạo, Hải Cảng, Thành phố Qui Nhơn, Bình Định')
INSERT [dbo].[Customer] ([customerId], [firstName], [lastName], [email], [phone], [address]) VALUES (4, N'Trần Minh', N'Tiến', N'tien@gmail.com', N'012321413123', N'201B Nguyễn Chí Thanh, Phường 12, Quận 5, Thành phố Hồ Chí Minh')
INSERT [dbo].[Customer] ([customerId], [firstName], [lastName], [email], [phone], [address]) VALUES (5, N'Nguyễn Thanh', N'Hoàng', N'hoang@gmail.com', N'012321413123', N'106 Đường Nguyễn Huệ, Trần Phú, Thành phố Qui Nhơn, Bình Định')
INSERT [dbo].[Customer] ([customerId], [firstName], [lastName], [email], [phone], [address]) VALUES (6, N'Cao Võ Minh', N'Anh', N'anh@gmail.com', N'012321413123', N'114 Trần Hưng Đạo - Quy Nhơn - Bình Định')
INSERT [dbo].[Customer] ([customerId], [firstName], [lastName], [email], [phone], [address]) VALUES (7, N'Võ Minh', N'Tuấn', N'phuoc@gmail.com', N'1212121212', N'HCM')
INSERT [dbo].[Customer] ([customerId], [firstName], [lastName], [email], [phone], [address]) VALUES (8, N'Lê Văn', N'Sơn', N'son@gmail.com', N'1212121212', N'HCM')
INSERT [dbo].[Customer] ([customerId], [firstName], [lastName], [email], [phone], [address]) VALUES (9, N'Nguyễn', N'Dũng', N'knguyn16@gmail.com', N'+84706437167', N'Quy Nhơn Bình Định')
INSERT [dbo].[Customer] ([customerId], [firstName], [lastName], [email], [phone], [address]) VALUES (10, N'Phạm Bảo', N'Long', N'long123@gmail.com', N'012445242', N'Phan Thiết')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
INSERT [dbo].[Invoince] ([invoinceNo], [dateOrder], [status], [deliveryStatus], [deliveryDate], [totalMoney], [userName], [customerId]) VALUES (N'HD12292021_224722', CAST(N'2021-12-29T22:47:22.620' AS DateTime), 1, 1, CAST(N'2023-06-10T09:29:33.107' AS DateTime), 3519000, NULL, 9)
INSERT [dbo].[Invoince] ([invoinceNo], [dateOrder], [status], [deliveryStatus], [deliveryDate], [totalMoney], [userName], [customerId]) VALUES (N'HD12302021_093555', CAST(N'2021-12-30T09:35:55.640' AS DateTime), 1, 1, CAST(N'2023-06-10T11:49:08.173' AS DateTime), 3519000, NULL, 10)
INSERT [dbo].[Invoince] ([invoinceNo], [dateOrder], [status], [deliveryStatus], [deliveryDate], [totalMoney], [userName], [customerId]) VALUES (N'HD6102023_102014', CAST(N'2023-06-10T10:20:14.910' AS DateTime), 1, 1, CAST(N'2023-06-10T11:49:12.033' AS DateTime), 74, N'xxxxxx', NULL)
INSERT [dbo].[Invoince] ([invoinceNo], [dateOrder], [status], [deliveryStatus], [deliveryDate], [totalMoney], [userName], [customerId]) VALUES (N'HD6102023_114318', CAST(N'2023-06-10T11:43:18.687' AS DateTime), 1, 1, CAST(N'2023-06-10T11:49:06.473' AS DateTime), 209, N'demo2', NULL)
INSERT [dbo].[Invoince] ([invoinceNo], [dateOrder], [status], [deliveryStatus], [deliveryDate], [totalMoney], [userName], [customerId]) VALUES (N'HD6102023_114340', CAST(N'2023-06-10T11:43:40.240' AS DateTime), 1, 1, CAST(N'2023-06-10T11:49:04.547' AS DateTime), 38, N'demo2', NULL)
INSERT [dbo].[Invoince] ([invoinceNo], [dateOrder], [status], [deliveryStatus], [deliveryDate], [totalMoney], [userName], [customerId]) VALUES (N'HD6102023_115511', CAST(N'2023-06-10T11:55:11.733' AS DateTime), 1, 0, NULL, 3519167, N'demo2', NULL)
INSERT [dbo].[Invoince] ([invoinceNo], [dateOrder], [status], [deliveryStatus], [deliveryDate], [totalMoney], [userName], [customerId]) VALUES (N'HD692023_232206', CAST(N'2023-06-09T23:22:06.990' AS DateTime), 1, 1, CAST(N'2023-06-10T09:29:27.050' AS DateTime), 59, N'xxxxxx', NULL)
INSERT [dbo].[Invoince] ([invoinceNo], [dateOrder], [status], [deliveryStatus], [deliveryDate], [totalMoney], [userName], [customerId]) VALUES (N'HD9162021_210615', CAST(N'2021-09-16T21:06:15.243' AS DateTime), 1, 0, NULL, 49, NULL, 3)
INSERT [dbo].[Invoince] ([invoinceNo], [dateOrder], [status], [deliveryStatus], [deliveryDate], [totalMoney], [userName], [customerId]) VALUES (N'HD9212021_185155', CAST(N'2021-09-21T18:51:55.123' AS DateTime), 1, 0, NULL, 25, NULL, 8)
GO
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD12292021_224722', 44, 1, 3519000, 3519000, 0)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD12302021_093555', 44, 1, 3519000, 3519000, 0)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD6102023_102014', 36, 1, 39, 39, 0)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD6102023_102014', 37, 1, 35, 35, 0)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD6102023_114318', 8, 1, 35, 32, 3)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD6102023_114318', 24, 2, 69, 138, 0)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD6102023_114318', 36, 1, 39, 39, 0)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD6102023_114340', 15, 1, 54, 38, 16)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD6102023_115511', 8, 1, 35, 32, 3)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD6102023_115511', 39, 1, 149, 135, 14)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD6102023_115511', 44, 1, 3519000, 3519000, 0)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD692023_232206', 8, 1, 35, 32, 3)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD692023_232206', 10, 1, 27, 27, 0)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD9162021_210615', 33, 1, 49, 49, 0)
INSERT [dbo].[InvoinceDetail] ([invoinceNo], [productId], [quanlityProduct], [unitPrice], [totalPrice], [totalDiscount]) VALUES (N'HD9212021_185155', 9, 1, 25, 25, 0)
GO
INSERT [dbo].[Member] ([userName], [password], [firstName], [lastName], [email], [birthday], [identityNumber], [phone], [dateOfJoin], [address], [avatar], [status], [roleId]) VALUES (N'admin', N'dad3a37aa9d50688b5157698acfd7aee', N'Nguyễn', N'Dũng', N'knguyn16@gmail.com', CAST(N'2001-12-08' AS Date), N'215516721', N'0706437167', CAST(N'2021-08-15T22:33:25.000' AS DateTime), N'300A Nguyễn Tất Thành, Phường 13, Quận 4, Tp.HCM', N'~/Content/img/avatar/avatar.jpg', 1, 1)
INSERT [dbo].[Member] ([userName], [password], [firstName], [lastName], [email], [birthday], [identityNumber], [phone], [dateOfJoin], [address], [avatar], [status], [roleId]) VALUES (N'admin123123', N'd138768d3b5eca407f0dd579c5ca3767', N'admin123123', N'admin123123', N'admin123123@gmail.com', CAST(N'2023-06-08' AS Date), N'123', N'9456564645', CAST(N'2023-06-11T12:07:02.643' AS DateTime), N'admin123123', N'~/Content/img/avatar/avatar.jpg', 1, 3)
INSERT [dbo].[Member] ([userName], [password], [firstName], [lastName], [email], [birthday], [identityNumber], [phone], [dateOfJoin], [address], [avatar], [status], [roleId]) VALUES (N'demo2', N'62cc2d8b4bf2d8728120d052163a77df', N'demo2', N'demo2', N'demo2@gmail.com', CAST(N'2023-06-08' AS Date), N'111', N'9456564645', CAST(N'2023-06-10T11:40:43.000' AS DateTime), N'hcm', N'~/Content/img/avatar/banner-thoi-trang-nam.jpg', 1, 3)
INSERT [dbo].[Member] ([userName], [password], [firstName], [lastName], [email], [birthday], [identityNumber], [phone], [dateOfJoin], [address], [avatar], [status], [roleId]) VALUES (N'democodedoan', N'e5ab543aa888688b33c2e48ce0898cda', N'democodedoan', N'democodedoan', N'democodedoan@gmail.com', CAST(N'2023-06-09' AS Date), N'12345', N'9456564645', CAST(N'2023-06-10T11:24:30.930' AS DateTime), N'xxx', N'~/Content/img/avatar/avatar.jpg', 1, 3)
INSERT [dbo].[Member] ([userName], [password], [firstName], [lastName], [email], [birthday], [identityNumber], [phone], [dateOfJoin], [address], [avatar], [status], [roleId]) VALUES (N'ffffff', N'eed8cdc400dfd4ec85dff70a170066b7', N'ffffff1', N'ffffff', N'ffffff@gmail.com', CAST(N'2023-06-09' AS Date), N'123456', N'9456564645', CAST(N'2023-06-10T09:35:46.000' AS DateTime), N'ffffff', N'~/Content/img/avatar/nnnnn.png', 1, 3)
INSERT [dbo].[Member] ([userName], [password], [firstName], [lastName], [email], [birthday], [identityNumber], [phone], [dateOfJoin], [address], [avatar], [status], [roleId]) VALUES (N'ntdung8124', N'ec04258de3dbf9e96b5775f301286785', N'Nguyễn Thanh', N'Dũng', N'ntdung8124@gmail.com', CAST(N'2000-12-08' AS Date), N'1212121212', N'0706437167', CAST(N'2021-09-15T16:19:28.000' AS DateTime), N'thành phố Quy Nhơn, tỉnh Bình Định', N'~/Content/img/avatar/me1.jpg', 1, 2)
INSERT [dbo].[Member] ([userName], [password], [firstName], [lastName], [email], [birthday], [identityNumber], [phone], [dateOfJoin], [address], [avatar], [status], [roleId]) VALUES (N'thanhvienmoi', N'25d55ad283aa400af464c76d713c07ad', N'thanhvienmoi', N'demo2', N'demo2@gmail.com', CAST(N'2023-06-09' AS Date), N'111', N'9456564645', CAST(N'2023-06-10T11:47:59.447' AS DateTime), N'hcm', N'~/Content/img/avatar/banner-thoi-trang-nam-tinh.jpg', 1, 2)
INSERT [dbo].[Member] ([userName], [password], [firstName], [lastName], [email], [birthday], [identityNumber], [phone], [dateOfJoin], [address], [avatar], [status], [roleId]) VALUES (N'xxxxxx', N'dad3a37aa9d50688b5157698acfd7aee', N'xxxxxx', N'xxxxxx', N'xxxxxx@gmail.com', CAST(N'2023-06-08' AS Date), N'123', N'0987654321', CAST(N'2023-06-09T23:20:12.280' AS DateTime), N'xxxxxx', N'~/Content/img/avatar/avatar.jpg', 1, 3)
GO
SET IDENTITY_INSERT [dbo].[Product] ON	/*[Sản phẩm]*/

INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (1, N'Reebok Club C Revenge Vintage Sneaker', N'~/Content/img/product/59752436_010_d.jpg', 80, 40, N'Retro-inspired sneakers by Reebok, the Club C Revenge GV7609 sneaker features a leather & suede upper with lightweight padding and cushioning throughout. Fitted with a lace closure to the front and finished with a textured outsole.', 50, N'Reebok', CAST(N'2021-08-15T22:33:25.783' AS DateTime), 1, 6, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (3, N'Happy Nuts Comfort Cream', N'~/Content/img/product/60727732_000_b.jpg', 14, 0, N'Keep it all fresh and comfy with this lightweight cream from Happy Nuts. Odor-neutralizing formula that goes on smooth and dries to a silky powder finish. Made with natural ingredients. Talc free.', 50, N'Happy Nuts', CAST(N'2021-08-15T22:33:25.783' AS DateTime), 1, 8, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (4, N'Ballsy All The Feels Organic Personal Lubricant', N'~/Content/img/product/63566228_000_b.jpg', 12, 0, N'By using only the highest-grade extracts including aloe, quinoa, hemp, flax and oat, All The Feels is enriched with vitamins and antioxidants that moisturize and protect your most intimate areas while leaving your skin feeling soft and never sticky so all you have to worry about is having fun.', 50, N'Ballsy', CAST(N'2021-08-15T22:33:25.783' AS DateTime), 1, 8, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (5, N'BDG Ribbed Boxer Brief', N'~/Content/img/product/61460689_044_b.jpg', 18, 0, N'Fitted ribbed knit boxer briefs by the essential BDG label. Features a classic look and stretch fabrication with elasticated waistband. Finished with logo text at the leg. Only at Urban Outfitters.', 50, N'BDG', CAST(N'2021-08-15T22:33:25.783' AS DateTime), 1, 7, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (6, N'UO Tie-Dye Corduroy Bucket Hat', N'~/Content/img/product/60803079_095_b.jpg', 19, 40, N'Corduroy bucket hat from Urban Outfitters with a classic look. Tie-dye wash effect hat with a flat top and stitched all-around brim.', 50, N'Urban Outfitters', CAST(N'2021-08-15T22:33:25.783' AS DateTime), 1, 7, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (7, N'Ray-Ban Wayfarer Sunglasses', N'~/Content/img/product/60627494_001_b.jpg', 154, 0, N'Classic sunglasses by Ray-Ban in the brand’s signature Wayfarer silhouette. Features a plastic frame with molded nose bridge and finished with tinted UV-blocking lenses.', 50, N'Ray-Ban', CAST(N'2021-08-15T22:33:25.783' AS DateTime), 1, 7, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (8, N'Fjallraven High Coast Pocket Pack Sling Bag', N'~/Content/img/product/59670893_072_b.jpg', 35, 10, N'Essential sling bag by Fjallraven with a zip closure and ideal for stowing the everyday essentials while on the go! Topped with an additional pocket to the front. Finished with an adjustable webbing shoulder strap.', 50, N'Fjallraven', CAST(N'2021-08-15T22:33:25.787' AS DateTime), 1, 7, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (9, N'Nike Air Tech Mini Crossbody Pouch', N'~/Content/img/product/60326949_001_b.jpg', 25, 0, N'Stow the essential in this zip pouch by Nike. Features organizational pockets & topped with an outer woven label. Finished with an adjustable webbing shoulder strap.', 50, N'Nike', CAST(N'2021-08-15T22:33:25.787' AS DateTime), 1, 7, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (10, N'Koa Anti-Pollution SPF 45+ Tinted Sunscreen', N'~/Content/img/product/60056637_000_b.jpg', 27, 0, N'Super-lightweight, mineral broad-spectrum daily sunscreen by Koa featuring proprietary technology to fight pollution-induced free radicals.', 50, N'Koa', CAST(N'2021-08-15T22:33:25.787' AS DateTime), 1, 8, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (11, N'BDG Bandana Print Volley Short', N'~/Content/img/product/61819884_040_b.jpg', 49, 10, N'Printed paisley pattern shorts by BDG with pockets at the sides & back. Fitted with an elasticated waistband & adjustable tie closure. Only at Urban Outfitters.', 50, N'BDG', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 4, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (12, N'UO Recycled Cotton 5” Lounge Short', N'~/Content/img/product/59345256_083_b.jpg', 29, 0, N'Everyday sport short by Urban Outfitters with a recycled cotton blend fabrication. Features an elasticated waistband, pockets at the waist & patch pocket to the back. Cut with a 5” inseam and finished with notched hems.', 50, N'Urban Outfitters', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 4, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (13, N'UO Lucien 5" Washed Awning Stripe Sweatshort', N'~/Content/img/product/61109468_041_b.jpg', 39, 0, N'Washed cotton-blend shorts by Urban Outfitters with an allover stripe pattern. Knit sweat shorts featuring pockets to the sides and back, fitted with an elastic waistband and adjustable drawcord.', 50, N'Urban Outfitters', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 4, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (14, N'Nike Trail Flex Stride Short', N'~/Content/img/product/58981671_023_b.jpg', 65, 10, N'Athletic shorts by Nike with a pull-on style & adjustable tie at the waistband. Finished with pockets at the sides and back.', 50, N'Nike', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 4, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (15, N'UO Corduroy Volley Short', N'~/Content/img/product/60156387_045_b.jpg', 54, 30, N'Classic volley short by Urban Outfitters with a cotton cord fabrication. Fitted with an elasticated waistband with adjustable tie accent. Includes pockets to the sides & a patch pocket at the back. Cut with a 5” inseam.', 50, N'Urban Outfitters', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 4, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (16, N'Crocs Classic Clog', N'~/Content/img/product/54296074_031_b.jpg', 50, 0, N'Original clogs from Crocs constructed from Croslite synthetic material. Water friendly, non-marking and lightweight, these clogs offer ventilation ports throughout the upper and padded toe and footbed for prime comfort levels. Finished with branded heel strap for a secure fit.', 50, N'Crocs', CAST(N'2021-08-15T22:33:25.783' AS DateTime), 1, 6, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (17, N'Teva Original Universal Urban Sandal', N'~/Content/img/product/48957484_001_b.jpg', 50, 0, N'Classically comfy Universal sandal from the experts at Teva. Cushy, molded footbed offers extra arch support while adjustable faded nylon straps provide a secure fit. Finished with a textured bottom for optimal traction. In 1984 a Grand Canyon river guide created an invitation for adventure by fusing a velcro watch strap with a flip flop - from that invention came the Teva Original, a sandal created to "strap in and go" for the spontaneous + adventurous with a go-anywhere and do-anything mentality.', 50, N'Teva', CAST(N'2021-08-15T22:33:25.783' AS DateTime), 1, 6, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (18, N'New Balance 574 Sneaker', N'~/Content/img/product/59468900_015_b.jpg', 80, 70, N'Core classic 574 sneaker by New Balance in a lightweight construction with suede and mesh upper. ENCAP midsole technology provides support while the EVA foam midsole provides cushioning. Finished on a lugged rubber outsole.', 50, N'New Balance', CAST(N'2021-08-15T22:33:25.783' AS DateTime), 1, 6, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (19, N'Fatboy Sea Salt Pomade', N'~/Content/img/product/43817436_000_b.jpg', 21, 10, N'Beachy waves without the crunch thanks to this innovative sea salt pomade from Fatboy. Provides flexibility with the texture + finish of your favorite sea salt sprays, while hydrating with a blend of coconut oil and shea butter.', 50, N'Fatboy', CAST(N'2021-08-15T22:33:25.787' AS DateTime), 1, 8, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (20, N'BRAVO SIERRA Lip Balm', N'~/Content/img/product/59361063_000_b.jpg', 6, 0, N'Protect and repair lips with this non-toxic balm enriched with murumuru butter – the vegetable-based alternative to silicones, rich in omega 3-6-9 fatty acids. Lightweight and non-greasy with a matte finish. Vegan and cruelty-free with no fragrance, flavor, parabens, silicones, sulfates, phthalates, PEGs or phenoxyethanol. Verified by the Environmental Working Group.', 50, N'BRAVO SIERRA', CAST(N'2021-08-15T22:33:25.787' AS DateTime), 1, 8, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (21, N'The North Face Black Box Tee', N'~/Content/img/product/59454488_030_b.jpg', 40, 0, N'Graphic tee by The North Face cut in a standard fit. 100% cotton t-shirt with short sleeves & a ribbed crew neck. Topped with a logo patch accent at the sleeve.', 100, N'The North Face', CAST(N'2021-08-15T22:33:25.773' AS DateTime), 1, 1, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (22, N'Patagonia P-6 Logo Organic Cotton Tee', N'~/Content/img/product/60451887_081_b.jpg', 36, 20, N'Organic cotton t-shirt by Patagonia cut in a standard fit with short sleeves and crew neck. Topped with logo detailing printed at the left chest & to the back.', 100, N'Patagonia', CAST(N'2021-08-15T22:33:25.773' AS DateTime), 1, 1, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (23, N'Hanes Beefy T X Rob Engvall Graphic Tee', N'~/Content/img/product/62412523_066_b.jpg', 36, 20, N'Short sleeve Hanes tee from the Artist Collection topped with Rob Engvall art prints to the front and back. Crafted from 100% cotton and cut in a standard fit with a ribbed knit crew neck. Only at Urban Outfitters.', 100, N'Hanes', CAST(N'2021-08-15T22:33:25.773' AS DateTime), 1, 1, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (24, N'BDG Waffle Check Overshirt', N'~/Content/img/product/61794277_053_b.jpg', 69, 0, N'Long sleeve button-down shirt by BDG. Features an allover waffle check pattern. Crafted from 100% cotton in a standard fit with flap pockets at the chest and a tab collar. Only at Urban Outfitters.', 100, N'BDG', CAST(N'2021-08-15T22:33:25.773' AS DateTime), 1, 2, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (25, N'Standard Cloth Waffle Stitch Polo Shirt', N'~/Content/img/product/61633210_021_d.jpg', 69, 20, N'Knit polo shirt by Standard Cloth with a button placket to the front and striped tipping at the tab collar. Ribbed fabrication crafted from 100% cotton with short sleeves. Only at Urban Outfitters.', 100, N'Standard Cloth', CAST(N'2021-08-15T22:33:25.773' AS DateTime), 1, 2, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (26, N'Standard Cloth Foundation Jogger Pant', N'~/Content/img/product/58201609_001_b.jpg', 39, 5, N'Wear-everywhere joggers from Standard Cloth, cut in a slim fit. Featuring a thick elastic waistband with adjustable drawstring, front slip pockets and tonally embroidered icon at the left hip. Finished with a single back patch pocket and rib-knit ankle cuffs.', 50, N'Standard Cloth', CAST(N'2021-08-15T22:33:25.773' AS DateTime), 1, 5, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (27, N'UO Wide Wale Corduroy Beach Pant', N'~/Content/img/product/58916743_055_b.jpg', 59, 40, N'Pull-on cord pants from Urban Outfitters. Beachy silhouette offers a wide leg with cropped hem, drawstring closure at elastic waistband and 3-pocket styling.', 50, N'Urban Outfitters', CAST(N'2021-08-15T22:33:25.777' AS DateTime), 1, 5, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (28, N'Grateful Dead Dancing Bears Sweatpant', N'~/Content/img/product/60770393_001_b.jpg', 69, 30, N'Grateful Dead sweatpants with a classic cotton poly fabrication cut in a relaxed fit & topped with a dancing bears motif. Fitted with an elasticated waistband and ankle cuffs.', 50, N'Washed Black', CAST(N'2021-08-15T22:33:25.777' AS DateTime), 1, 5, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (29, N'Nike Challenger OG Sneaker', N'~/Content/img/product/58879487_001_b.jpg', 90, 0, N'The classic athletic sneaker by Nike with a low-profile upper and lace-up front. Features a leather & textile upper with essential Nike swoosh detailing to the sides. Finished with a grippy rubber outsole.', 50, N'Nike', CAST(N'2021-08-15T22:33:25.777' AS DateTime), 1, 6, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (30, N'Reebok UO Exclusive Club C 85 Sneaker', N'~/Content/img/product/48679617_010_b.jpg', 70, 0, N'Amp up your sneaker style with this Reebok rendition of the classic Club C DV3894 kick. Low-cut design with a soft leather upper, die-cut EVA midsole and molded sockliner for cushioned support. Features a timeless Reebok window box logo at quarter panel and ultra-padded tongue. Set on a high-abrasion rubber outsole. Get it only at UO!', 50, N'Reebok', CAST(N'2021-08-15T22:33:25.777' AS DateTime), 1, 6, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (31, N'Dr. Martens 2976 Bex Chelsea Boots', N'~/Content/img/product/56996697_001_b.jpg', 160, 0, N'Classic Chealsea style boots by Dr. Martens featuring a smooth leather upper with elasticated side panel accents set atop a bold lugged sole. Includes a pull tab at the heel and finished with contrast outstitch detailing.', 50, N'Dr. Martens', CAST(N'2021-08-15T22:33:25.777' AS DateTime), 1, 6, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (32, N'UO Quarter-Zip Polo Shirt', N'~/Content/img/product/61165650_030_d.jpg', 49, 20, N'Sporty stripe polo style shirt with a 100% cotton shirt. Short sleeve style in a standard fit with a partial zip placket to the front and tab collar.', 100, N'Urban Outfitters', CAST(N'2021-08-15T22:33:25.777' AS DateTime), 1, 2, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (33, N'Without Walls Gauze Stripe Shirt', N'~/Content/img/product/60891710_009_d.jpg', 49, 0, N'Stripe pattern shirt by Without Walls with a cotton fabrication. Short sleeve style with a button-down front, notched collar and left chest pocket. Only at Urban Outfitters.', 100, N'Without Walls', CAST(N'2021-08-15T22:33:25.777' AS DateTime), 1, 2, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (34, N'UO Ecru Stripe Grandpa Collar Shirt', N'~/Content/img/product/73715476_011_b.jpg', 69, 0, N'Mix-and-match striped shirt, made from a soft and textured fabrication. With a grandpa-style collar, a button placket, drop shoulders, long sleeves and buttoned cuffs. Finished with a patch pocket to chest with embroidered motif.', 100, N'Urban Outfitters', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 2, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (35, N'Nike Sportswear M2Z Tee', N'~/Content/img/product/60337201_011_b.jpg', 40, 0, N'T-shirt by Nike topped with a graphic to the front. Crafted from 100% cotton in a standard fit with short sleeves & a ribbed knit crew neck.', 100, N'Nike', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 1, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (36, N'ULTRA GAME Los Angeles Lakers Vintage Collegiate Text Tee', N'~/Content/img/product/61322335_001_b.jpg', 39, 0, N'Los Angeles Lakers tee by ULTRA GAME topped with a vintage look graphic printed to the front. Short sleeve cotton tee cut in a standard fit with classic crew neck.', 100, N'ULTRA GAME', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 1, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (37, N'Hanes Beefy T X Rob Engvall Graphic Teexxx', N'~/Content/img/product/62412473_010_b.jpg', 35, 0, N'', 100, N'Hanes', CAST(N'2021-08-15T22:33:25.000' AS DateTime), 1, 1, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (38, N'UO Big Corduroy Work Shirt', N'~/Content/img/product/55150924_033_b.jpg', 69, 10, N'Big corduroy work shirt from Urban Outfitters. Cut in a slightly oversized silhouette, this cotton cord shirt offers a full-length button-front closure, pointed collar and single patch pocket at the chest. Complete with long sleeves with adjustable button cuffs, yoked back and a split, rounded hemline.', 100, N'Urban Outfitters', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 3, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (39, N'Urban Renewal Remnants Upcycled Quilt Applique Linen Chore Coat', N'~/Content/img/product/62337837_012_b.jpg', 149, 10, N'Chore coat topped with upcycled quilt patch accents at the pocket and back. Features a button placket to the front & tab collar. Each is unique & will vary from what is pictured.', 100, N'Urban Renewal', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 3, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (40, N'Patagonia Classic Retro-X Fleece Jacket', N'~/Content/img/product/56909161_014_b.jpg', 199, 0, N'Warm and windproof, this Retro-X jacket from Patagonia is your new staple fleece jacket. Windproof membrane bonded between ¼"-pile sherpa fleece exterior and a moisture-wicking, highly air-permeable warp-knit mesh features a full-zip front with internal wind flap, Y-Joint sleeves for added mobility and vertical zippered chest pocket in a contrast hue. Finished with zippered handwarmers lined with brushed-polyester mesh.', 100, N'Patagonia', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 3, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (41, N'UO Lucien 5" Vintage Wash Short', N'~/Content/img/product/59291740_045_b.jpg', 39, 0, N'Garment dye sweat shorts from Urban Outfitters with a faded wash effect. In a relaxed fit with adjustable drawstring at the waist and pockets to the sides.', 50, N'Urban Outfitters', CAST(N'2021-08-15T22:33:25.780' AS DateTime), 1, 4, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (44, N'Nike Dunk High Retro SE', N'~/Content/img/product/270135095_504164211179085_3028213436526986462_n.png', 3519000, 0, N'', 2, N'Jodan', CAST(N'2021-12-29T22:23:07.000' AS DateTime), 1, 1, N'admin')
INSERT [dbo].[Product] ([productId], [productName], [image], [price], [discount], [description], [quanlity], [brand], [dateCreate], [status], [categoryId], [userName]) VALUES (45, N'demo them sp', N'~/Content/img/product/nnnnn.png', 4500, 12, N'<p>xxxx</p>', 22, N'abc', CAST(N'2023-06-10T11:46:20.343' AS DateTime), 1, 5, N'admin')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON /*[Danh mục sản phẩm]*/

INSERT [dbo].[ProductCategory] ([categoryId], [categoryName]) VALUES (1, N'T-shirt')
INSERT [dbo].[ProductCategory] ([categoryId], [categoryName]) VALUES (2, N'Shirt')
INSERT [dbo].[ProductCategory] ([categoryId], [categoryName]) VALUES (3, N'Jacket')
INSERT [dbo].[ProductCategory] ([categoryId], [categoryName]) VALUES (4, N'Short')
INSERT [dbo].[ProductCategory] ([categoryId], [categoryName]) VALUES (5, N'Pant')
INSERT [dbo].[ProductCategory] ([categoryId], [categoryName]) VALUES (6, N'Shoes')
INSERT [dbo].[ProductCategory] ([categoryId], [categoryName]) VALUES (7, N'Accessories')
INSERT [dbo].[ProductCategory] ([categoryId], [categoryName]) VALUES (8, N'Grooming')
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON			/*[Vai trò]*/

INSERT [dbo].[Role] ([roleId], [roleName]) VALUES (1, N'Manager')
INSERT [dbo].[Role] ([roleId], [roleName]) VALUES (2, N'Employee')
INSERT [dbo].[Role] ([roleId], [roleName]) VALUES (3, N'Customer')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
ALTER TABLE [dbo].[Article] ADD  DEFAULT (getdate()) FOR [publicDate]
GO
ALTER TABLE [dbo].[Contact] ADD  DEFAULT (getdate()) FOR [dateContact]
GO
ALTER TABLE [dbo].[Invoince] ADD  DEFAULT (getdate()) FOR [dateOrder]
GO
ALTER TABLE [dbo].[InvoinceDetail] ADD  DEFAULT ((0)) FOR [quanlityProduct]
GO
ALTER TABLE [dbo].[InvoinceDetail] ADD  DEFAULT ((0)) FOR [totalPrice]
GO
ALTER TABLE [dbo].[InvoinceDetail] ADD  DEFAULT ((0)) FOR [totalDiscount]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT (getdate()) FOR [dateOfJoin]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ('avatar.jpg') FOR [avatar]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [quanlity]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ('No brand') FOR [brand]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT (getdate()) FOR [dateCreate]
GO
ALTER TABLE [dbo].[Slide] ADD  DEFAULT (getdate()) FOR [dateCreate]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_POST_CATEGORY] FOREIGN KEY([categoryId])
REFERENCES [dbo].[ProductCategory] ([categoryId])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_POST_CATEGORY]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_POST_MEMBER] FOREIGN KEY([userName])
REFERENCES [dbo].[Member] ([userName])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_POST_MEMBER]
GO
ALTER TABLE [dbo].[Invoince]  WITH CHECK ADD  CONSTRAINT [FK_INVOINCE_CUSTOMER] FOREIGN KEY([customerId])
REFERENCES [dbo].[Customer] ([customerId])
GO
ALTER TABLE [dbo].[Invoince] CHECK CONSTRAINT [FK_INVOINCE_CUSTOMER]
GO
ALTER TABLE [dbo].[Invoince]  WITH CHECK ADD  CONSTRAINT [FK_INVOINCE_MEMBER] FOREIGN KEY([userName])
REFERENCES [dbo].[Member] ([userName])
GO
ALTER TABLE [dbo].[Invoince] CHECK CONSTRAINT [FK_INVOINCE_MEMBER]
GO
ALTER TABLE [dbo].[InvoinceDetail]  WITH CHECK ADD  CONSTRAINT [FK_INVOINCEDETAIL_INVOINCE] FOREIGN KEY([invoinceNo])
REFERENCES [dbo].[Invoince] ([invoinceNo])
GO
ALTER TABLE [dbo].[InvoinceDetail] CHECK CONSTRAINT [FK_INVOINCEDETAIL_INVOINCE]
GO
ALTER TABLE [dbo].[InvoinceDetail]  WITH CHECK ADD  CONSTRAINT [FK_INVOINCEDETAIL_PRODUCT] FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([productId])
GO
ALTER TABLE [dbo].[InvoinceDetail] CHECK CONSTRAINT [FK_INVOINCEDETAIL_PRODUCT]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_MEMBER_ROLE] FOREIGN KEY([roleId])
REFERENCES [dbo].[Role] ([roleId])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_MEMBER_ROLE]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_CATEGORY] FOREIGN KEY([categoryId])
REFERENCES [dbo].[ProductCategory] ([categoryId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_PRODUCT_CATEGORY]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_MEMBER] FOREIGN KEY([userName])
REFERENCES [dbo].[Member] ([userName])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_PRODUCT_MEMBER]
GO
USE [master]
GO
ALTER DATABASE [menfashion] SET  READ_WRITE 
GO
