<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<html>
<head>
	<title>Image Gallery</title>
</head>
<body>
    <form id="frmMainImageGallery" runat="server" enctype="multipart/form-data">  
		<FTB:ImageGallery id="ImageGallery"   
			JavaScriptLocation="InternalResource"
			UtilityImagesLocation="InternalResource" 
			AllowImageDelete="true" AllowImageUpload="true" AllowDirectoryCreate="true" AllowDirectoryDelete="true" runat="Server"  />
	</form>
</body>
</html>

