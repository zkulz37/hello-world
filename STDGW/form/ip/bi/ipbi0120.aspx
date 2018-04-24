<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("STM")%>
<script>

var status;

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	OnAddnewData('STYLE')
    //---------------------------------- 
	<%=ESysLib.SetGridColumnComboFormat( "grdListDSP" , 5 , "SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0018'") %>;
	<%=ESysLib.SetGridColumnComboFormat( "grdListDSD" , 5 , "SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0018'") %>;
	<%=ESysLib.SetGridColumnComboFormat( "grdListDSD" , 3 , "SELECT D.PK, RPAD(D.DEFECT_ID,10,' ') || ' : ' || D.DEFECT_NAME FROM TST_DEFECT D WHERE D.DEL_IF = 0 AND D.USE_YN = 'Y'") %>;
	//alert();
	//datMStyleYear.text = '2009';
	imgFile.SetEnable(false);
}


/*#######################################################################################*/
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="80%";
    imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}

/*#######################################################################################*/
function OnDataReceive(obj)
{
	if(obj.id == "datStyleMaster")
	{
		OnSearchTab();
	}
	else
	{
		return;
	}
}

/*#######################################################################################*/
function ResetForm()
{
	txtMStyle_PK.text = "";
	OnSearchTab();
}

/*#######################################################################################*/
function OnAddnewData(key)
{
	//'NEW_STYLE'
	if(key == "STYLE")
	{
		datStyleMaster.StatusInsert();
		ResetForm();
	}
	/*===================================================================================*/
	else if(key == "STYLE_COLOR")
	{
		if(txtMStyle_PK.text == "")
		{
			alert("Unknow Master style or Not selected ! Please try again");
			return;
		}
		for(i=1; i<grdListDSC.rows;i++)
		{
			if (grdListDSC.GetRowStatus(i) == 32 ) 
			{
				alert("An empty row existed ! Please input data");
				return;
			}
		}
		grdListDSC.AddRow();
		var mapCtrl = grdListDSC.GetGridControl();
		mapCtrl.TextMatrix(grdListDSC.rows - 1 , 1) = txtMStyle_PK.text;
		return;
	}
	
	/*===================================================================================*/
	else if(key == "STYLE_SIZE")
	{
		if(txtMStyle_PK.text == "")
		{
			alert("Unknow Master style or Not selected ! Please try again")
			return;
		}
		for(i=1; i<grdListDSS.rows;i++)
		{
			if (grdListDSS.GetRowStatus(i) == 32 ) 
			{
				alert("An empty row existed ! Please input data");
				return;
			}
		}
		grdListDSS.AddRow();
		var mapCtrl = grdListDSS.GetGridControl();
		mapCtrl.TextMatrix(grdListDSS.rows - 1 , 1) = txtMStyle_PK.text;
		return;
	}
	/*===================================================================================*/
	else if(key == "STYLE_CUTPART")
	{
		if(txtMStyle_PK.text == "")
		{
			alert("Unknow Master style or Not selected ! Please try again")
			return;
		}
		for(i=1; i<grdListDSP.rows;i++)
		{
			if (grdListDSP.GetRowStatus(i) == 32 ) 
			{
				alert("An empty row existed ! Please input data");
				return;
			}
		}
		grdListDSP.AddRow();
		var mapCtrl = grdListDSP.GetGridControl();
		mapCtrl.TextMatrix(grdListDSP.rows - 1 , 1) = txtMStyle_PK.text;
		return;
	}
	/*===================================================================================*/
	else if(key == "STYLE_DEFECT")
	{
		if(txtMStyle_PK.text == "")
		{
			alert("Unknow Master style or Not selected ! Please try again")
			return;
		}
		for(i=1; i<grdListDSD.rows;i++)
		{
			if (grdListDSD.GetRowStatus(i) == 32 ) 
			{
				alert("An empty row existed ! Please input data");
				return;
			}
		}
		grdListDSD.AddRow();
		var mapCtrl = grdListDSD.GetGridControl();
		mapCtrl.TextMatrix(grdListDSD.rows - 1 , 1) = txtMStyle_PK.text;
		return;
	}
	/*===================================================================================*/
	else if(key == "STYLE_PICTURE")
	{	if(txtMStyle_PK.text == "")
		{
			alert("Unknow Master style or Not selected ! Please try again")
			return;
		}
		/*for(i=1; i<grdListDST.rows;i++)
		{
			if (grdListDST.GetRowStatus(i) == 32 ) 
			{
				alert("An empty row existed ! Please input data");
				return;
			}
		}*/
		grdListDST.AddRow();
		var mapCtrl = grdListDST.GetGridControl();
		mapCtrl.TextMatrix(grdListDST.rows - 1 , 1) = txtMStyle_PK.text;
		return;
	}
	/*===================================================================================*/
	else { return; }
}

function OnDeleteData(key)
{
	//'NEW_STYLE'
	/*===================================================================================*/
	if(key == "STYLE")
	{
		if ( confirm('Do you want to delete ?'))
		{
			datStyleMaster.StatusDelete();
		}
			return;
	}
	/*===================================================================================*/
	else if(key == "STYLE_COLOR")
	{
		var mapctrl = grdListDSC.GetGridControl();
		for(i=1; i < grdListDSC.rows;i++)
		{
			if (mapctrl.IsSelected(i)) 
			{
				grdListDSC.DeleteRowAt(i)
			}
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_SIZE")
	{
		var mapctrl = grdListDSS.GetGridControl();
		for(i=1; i < grdListDSS.rows;i++)
		{
			if (mapctrl.IsSelected(i)) 
			{
				grdListDSS.DeleteRowAt(i);
			}
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_CUTPART")
	{
		var mapctrl = grdListDSP.GetGridControl();
		for(i=1; i < grdListDSP.rows;i++)
		{
			if (mapctrl.IsSelected(i)) 
			{
				grdListDSP.DeleteRowAt(i);
			}
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_DEFECT")
	{
		var mapctrl = grdListDSD.GetGridControl();
		for(i=1; i < grdListDSD.rows;i++)
		{
			if (mapctrl.IsSelected(i)) 
			{
				grdListDSD.DeleteRowAt(i);
			}
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_PICTURE")
	{
		var mapctrl = grdListDST.GetGridControl();
		for(i=1; i < grdListDST.rows;i++)
		{
			if (mapctrl.IsSelected(i)) 
			{
				grdListDST.DeleteRowAt(i);
			}
		}
	}
	/*===================================================================================*/
	else { return; }
}

/*#######################################################################################*/
function OnUnDeleteData(key)
{
	/*===================================================================================*/
	if(key == "STYLE")
	{
		return;
	}
	/*===================================================================================*/
	else if(key == "STYLE_COLOR")
	{
		var mapctrl = grdListDSC.GetGridControl();
		for(i=1; i<grdListDSC.rows;i++)
		{
			if (mapctrl.IsSelected(i)) 
			{
				grdListDSC.UnDeleteRowAt(i)
			}
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_SIZE")
	{
		var mapctrl = grdListDSS.GetGridControl();
		for(i=1; i<grdListDSS.rows;i++)
		{
			if (mapctrl.IsSelected(i)) 
			{
				grdListDSS.UnDeleteRowAt(i);
			}
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_CUTPART")
	{
		var mapctrl = grdListDSP.GetGridControl();
		for(i=1; i<grdListDSP.rows;i++)
		{
			if (mapctrl.IsSelected(i)) 
			{
				grdListDSP.UnDeleteRowAt(i);
			}
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_DEFECT")
	{
		var mapctrl = grdListDSD.GetGridControl();
		for(i=1; i<grdListDSD.rows;i++)
		{
			if (mapctrl.IsSelected(i)) 
			{
				grdListDSD.UnDeleteRowAt(i);
			}
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_PICTURE")
	{
		var mapctrl = grdListDST.GetGridControl();
		for(i=1; i<grdListDST.rows;i++)
		{
			if (mapctrl.IsSelected(i)) 
			{
				grdListDST.UnDeleteRowAt(i);
			}
		}
	}
	else
	{
		return;
	}
}

/*#######################################################################################*/
function OnSearchData(key)
{
	
	if(key == "STYLE")
	{
		dsoDataList.Call("SELECT");
		return;
	}
	else
	{
		return;
	}
}

/*#######################################################################################*/
function OnSearchTab()
{
    if(txtMStyle_PK.text != "")
    {
        if (idTab_Detail.GetCurrentPageNo() == 0)
        {
			dsoStyleColor.Call("SELECT");
        }
		else if (idTab_Detail.GetCurrentPageNo() == 1)
        {
			dsoStyleSize.Call("SELECT");
        }
		else if (idTab_Detail.GetCurrentPageNo() == 2)
        {
			dsoStyleCutPart.Call("SELECT");
        }
		else if (idTab_Detail.GetCurrentPageNo() == 3)
        {
			dsoStyleDefect.Call("SELECT");
        }
		else if (idTab_Detail.GetCurrentPageNo() == 4)
        {
			dsoStylePicture.Call("SELECT");
			imgFile.SetDataText(0); 
        }
		else
		{
			return;
		}
    }
	else
	{
		if (idTab_Detail.GetCurrentPageNo() == 0)
        {
			grdListDSC.ClearData();
			grdListDSC.Refresh();
        }
		else if (idTab_Detail.GetCurrentPageNo() == 1)
        {
			grdListDSS.ClearData();
			grdListDSS.Refresh();
        }
		else if (idTab_Detail.GetCurrentPageNo() == 2)
        {
			grdListDSP.ClearData();
			grdListDSP.Refresh();
        }
		else if (idTab_Detail.GetCurrentPageNo() == 3)
        {
			
        }
		else if (idTab_Detail.GetCurrentPageNo() == 4)
        {
			grdListDST.ClearData();
			grdListDST.Refresh();
			imgFile.SetDataText(0); 
        }
		else
		{
			return;
		}					
	}
}

/*#######################################################################################*/
function OnSelectSearchResult()
{
	if(grdList.rows <= 1)
	{
		return;
	}
	else
	{
		txtMStyle_PK.text = grdList.GetGridData( grdList.row, 0 );
		if(txtMStyle_PK.text == "")
		{
			return;
		}
		else
		{
			datStyleMaster.Call("SELECT");
			
		}
	}
}

/*#######################################################################################*/
function OnSaveChangedData(key)
{
	//'NEW_STYLE'
	
	/*===================================================================================*/
	if(key == "STYLE")
	{
		if( CheckDataIsValid("STYLE") == true )
            {
                datStyleMaster.Call();
                return;
            }
	}
	/*===================================================================================*/
	else if(key == "STYLE_COLOR")
	{
		if(CheckDataIsValid("STYLE_COLOR") == false)
		{
			return;
		}else
		{
			dsoStyleColor.Call();
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_SIZE")
	{
		if(CheckDataIsValid("STYLE_SIZE") == false)
		{
			return;
		}else
		{
			dsoStyleSize.Call();
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_CUTPART")
	{
		if(CheckDataIsValid("STYLE_CUTPART") == false)
		{
			return;
		}else
		{
			dsoStyleCutPart.Call();
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_DEFECT")
	{
		if(CheckDataIsValid("STYLE_DEFECT") == false)
		{
			return;
		}else
		{
			dsoStyleDefect.Call();
		}
	}
	/*===================================================================================*/
	else if(key == "STYLE_PICTURE")
	{
		if(CheckDataIsValid("STYLE_PICTURE") == false)
		{
			return;
		}else
		{
			dsoStylePicture.Call();
		}
	}
	/*===================================================================================*/
	else 
	{ 
		alert("Save " + key + " false");
		return; 
	}
}


/*#######################################################################################*/
function CheckDataIsValid(key)
{
	/*===================================================================================*/
	if(key == "STYLE")
	{
		if( lstMBrand.value == "" )
		{
			alert("Brand can not empty. You must select one !");
			return false;
		}
		else if( txtMStyleNo.text == "")
		{
			alert("Style No can not empty. Please input data !");
			return false;
		}
		else if( txtMStyleDesc.text == "")
		{
			alert("Style Desciption can not empty. Please input data !");
			return false;
		}
		return true;
	}
	/*===================================================================================*/
	else if(key == "STYLE_COLOR")
	{
		if(CheckValidValue(grdListDSC, 1, "", "Unknown Style. Please select one" ) == false 
			|| CheckValidValue(grdListDSC, 3, "", "Style color ID can not empty" ) == false 
			|| CheckValidValue(grdListDSC, 4, "", "Style color name can not empty" ) == false )
		{
			return false;
		}
		else if(CheckDupplicateData(grdListDSC,3 ) > 0)
		{
			return false;
		}
		return true;
	}
	/*===================================================================================*/
	else if(key == "STYLE_SIZE")
	{
		if(CheckValidValue(grdListDSS, 1, "", "Unknown Style. Please select one" ) == false 
			|| CheckValidValue(grdListDSS, 3, "", "Style Size Information can not empty" ) == false  )
		{
			return false;
		}
		else if(CheckDupplicateData(grdListDSC,3 ) > 0)
		{
			return false;
		}
		return true;
	}
	/*===================================================================================*/
	else if(key == "STYLE_CUTPART")
	{
		if(CheckValidValue(grdListDSP, 1, "", "Unknown Style. Please select one" ) == false 
			|| CheckValidValue(grdListDSP, 3, "", "Cut part ID can not empty" ) == false
			|| CheckValidValue(grdListDSP, 4, "", "Cut part name can not empty" ) == false			)
		{
			return false;
		}
		else if(CheckDupplicateData(grdListDSP,3 ) > 0)
		{
			return false;
		}
		return true;
	}
	/*===================================================================================*/
	else if(key == "STYLE_DEFECT")
	{
		if(CheckValidValue(grdListDSD, 1, "", "Unknown Style. Please select one" ) == false 
			|| CheckValidValue(grdListDSD, 3, "", "Defect can not empty" ) == false )
		{
			return false;
		}
		else if(CheckDupplicateData(grdListDSD,3 ) > 0)
		{
			return false;
		}
		return true;
	}
	/*===================================================================================*/
	else if(key == "STYLE_PICTURE")
	{
		return true;
		if(CheckValidValue(grdListDST, 1, "", "Unknown Style. Please select one" ) == false )
		{
			return false;
		}
		return true;
	}
	/*===================================================================================*/
	else
		return false;
}

/*#######################################################################################*/
function OnClickUpload()
{  
    if (grdListDST.col == 4)
    {
		var mapCtrl = grdListDST.GetGridControl();
		var key = mapCtrl.TextMatrix(grdListDST.row , 0);
		if(key == 0 || key == "")
		{
			imgFile.SetDataText(0);
		}
		imgFile.ChangeImage();
		var pic_pk = imgFile.GetData();
		if(pic_pk == 0)
		{
			return;
		}
		else
		{
			//alert(pic_pk);
			imgFile.SetDataText(pic_pk);
			mapCtrl.TextMatrix(grdListDST.row, 0) = pic_pk;
		}
		
    }   
}

/*#######################################################################################*/
function SelectPicture()
{  
    var mapCtrl = grdListDST.GetGridControl();
	if(mapCtrl.TextMatrix(grdListDST.row , 0) == "")
	{
		return;
	}	
	//alert(mapCtrl.TextMatrix(grdListDST.row , 0))
	imgFile.SetDataText(mapCtrl.TextMatrix(grdListDST.row , 0)); 
}

/*#######################################################################################*/
function CheckDupplicateData(obj,col )
{
    if(col < 0)
        return -1; // khong trung
    if(obj.Rows <= 1)
        return 0; // khong trung
    var tmp = obj.GetGridControl();
    for(i=1; i<obj.rows; i++)
    {
        for( j = i+1; j<obj.rows; j++)
		{
			if(tmp.TextMatrix(i , col).toUpperCase() == tmp.TextMatrix(j , col).toUpperCase())
			{
				lb = ("Duplicate data at row : " + j + " with value : " + tmp.TextMatrix(j , col));
				alert(lb)
				return i;
			}
		}
    }
    return 0; // khong trung
}

/*#######################################################################################*/
function CheckValidValue(obj, col, values, msg )
{
    if(col < 0)
        return true; // Du lieu tai cot [col] trong [obj] khong trung voi [values]
    if(obj.Rows <= 1)
        return true; 
    var tmp = obj.GetGridControl();
    for(i=1; i<obj.rows; i++)
    {
        if(tmp.TextMatrix(i , col) == values)
		{
			alert(msg)
			return false; // Du lieu tai cot [col] trong [obj] trung voi [values]
		}
    }
    return true; // khong trung
}

/*#######################################################################################*/
function CheckValidValueOnCell(obj, col, row, values, msg )
{
    if(col < 0)
        return true; // Du lieu tai cot [col] trong [obj] khong trung voi [values]
    if(obj.Rows <= 1)
        return true; 
    var tmp = obj.GetGridControl();
    if(tmp.TextMatrix(row , col) == values)
	{
		alert(msg)
		return false; // Du lieu tai cot [col] trong [obj] trung voi [values]
	}
    return true; // khong trung
}

/*#######################################################################################*/
function OnDataError(obj)
{
	if (obj.id=="datStyleMaster")
    {
		AlertDBError(obj.errmsg);
		return;
	}
	if (obj.id=="dsoStyleColor")
    {
		AlertDBError(obj.errmsg);
		return;
	}
	else
	{
		alert(obj.errmsg);
	}
}

/*#######################################################################################*/
function AlertDBError(errmsg)
{
	var aTmp = new Array();
	aTmp = errmsg.split("ORA-");
	if(aTmp.length >= 2)
	{
		alert(aTmp[1]);
	}
	else 
	{
		alert(errmsg);
	}
}

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Style Entry</title>
</head>
<body>

<!--------------------------------------------------------------------------->
    <gw:data id="datStyleMaster" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
        <xml> 
            <dso type="control"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13"  function="STM.SP_SEL_STYLE_LIST" procedure="STM.SP_UPD_STYLE_ENTRY" > 
                <inout> 
                    <inout bind="txtMStyle_PK" />
                    <inout bind="lstMBrand" />
                    <inout bind="lstMGender" />
                    <inout bind="txtMStyleNo" />                    
                    <inout bind="txtMStyleDesc" />
                    <inout bind="datMStyleYear" />                    
                    <inout bind="lstMStyleSeason" />
                    <inout bind="lstMStyleUnit" />
					<inout bind="lstMStyleCurrency" />
                    <inout bind="txtMUnitPrice" />  
					<inout bind="txtMStyleRemark" />  
                    <inout bind="datMStyleDateST" />
                    <inout bind="datMStyleDateEnd" />
                    <inout bind="optMStyleActive" />
                </inout> 
            </dso>
        </xml>
    </gw:data>

<gw:data id="dsoDataList"  onreceive="OnDataReceive(this)" onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,4,5" function="STM.SP_SEL_STYLE_LIST_SEARCH"  > 
            <input bind="grdList"  > 
				<input bind="lstSBrand" /> 
				<input bind="txtSFilterValue" /> 	
            </input> 
            <output bind="grdList" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoStyleColor"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,4,5,6" function="STM.SP_SEL_STYLECOLOR_LIST"  procedure="STM.SP_UPD_STYLECOLOR_ENTRY"  > 
            <input bind="grdListDSC"  > 
				<input bind="txtMStyle_PK" /> 	
            </input>
            <output bind="grdListDSC" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoStyleSize"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,4" function="STM.SP_SEL_STYLESIZE_LIST"  procedure="STM.SP_UPD_STYLESIZE_ENTRY"  > 
            <input bind="grdListDSS"  > 
				<input bind="txtMStyle_PK" /> 	
            </input>
            <output bind="grdListDSS" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoStyleCutPart"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="STM.SP_SEL_STYLECUTPART_LIST"  procedure="STM.SP_UPD_STYLECUTPART_ENTRY"  > 
            <input bind="grdListDSP"  > 
				<input bind="txtMStyle_PK" /> 	
            </input>
            <output bind="grdListDSP" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoStyleDefect"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="STM.SP_SEL_STYLEDEFECT_LIST"  procedure="STM.SP_UPD_STYLEDEFECT_ENTRY"  > 
            <input bind="grdListDSD"  > 
				<input bind="txtMStyle_PK" /> 	
            </input>
            <output bind="grdListDSD" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoStylePicture"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3" function="STM.SP_SEL_STYLEPIC_LIST"  procedure="STM.SP_UPD_STYLEPIC_ENTRY"  > 
            <input bind="grdListDST"  > 
				<input bind="txtMStyle_PK" /> 	
            </input>
            <output bind="grdListDST" /> 
        </dso> 
    </xml> 
</gw:data> 

	<table width="100%" height="100%" border="1">
		<tr>
			<td id="left"  width="25%">
				<table width="100%" height="100%" border="0">
					<tr height="5%">
						<td>
							<table width="100%" height="100%" border="0">
								<tr height="5%" >
									<td width="1%">&nbsp;</td>
									<td width="80">Brand</td>
									<td  width="60%">
										<gw:list  id="lstSBrand" value ="ALL" styles='width:100%'onchange="OnSearchData('STYLE')" >
											<data>
												<%=ESysLib.SetListDataSQL("SELECT B.PK, B.BRAND_ID FROM TST_BRAND B WHERE B.DEL_IF = 0 AND B.USE_YN = 'Y' ORDER BY B.BRAND_ID")%> |ALL|Select All
											</data>
										</gw:list>
									</td>
									<td >&nbsp;</td>
									<td ></td>
									<td width="1%">&nbsp;</td>
								</tr>
								<tr height="5%">
									<td width="1%">&nbsp;</td>
									<td width="80">Search Value</td>
									<td width="12%"><gw:textbox id="txtSFilterValue" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData('STYLE')"  /></td>
									<td >&nbsp;</td>
									<td ><gw:imgBtn id="btnSSearch" img="search" alt="Search Style Information" onclick="OnSearchData('STYLE')" /></td>
									<td width="1%">&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>					
					<tr height="100%">
						<td  width="100%" >
							<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<gw:grid   
											id="grdList"  
											header="_PK|Style ID|Description|Style year"
											format="0|0|0|0"
											aligns="0|0|0|0"
											defaults="|||"
											editcol="0|0|0|0"
											widths="0|1500|2000|1000"
											styles="width:100%; height:100%"   
											sorting="T"   
											acceptNullDate
											param="0,1,2,3" onSelChange="" OnClick="OnSelectSearchResult()"  />
									</td>
								</tr>
							</table>
						</td>	
					</tr>
				</table>
			</td>
				<td  id="right"  width="75%">
					<table width="100%" height="100%" border="0">
						<tr height="10%">
							<td>
<!------------------------------------------------------------------------------------------------------------------------>
								<table width="100%" border="0">
									<tr>
										<td width="10%"><div align="right"><strong>Brand</strong></div></td>
										<td colspan="3">
											<gw:list  id="lstMBrand" value ="ALL" styles='width:100%'onchange="" >
												<data>
													<%=ESysLib.SetListDataSQL("SELECT B.PK, B.BRAND_ID FROM TST_BRAND B WHERE B.DEL_IF = 0 AND B.USE_YN = 'Y' ORDER BY B.BRAND_ID")%> 
												</data>
											</gw:list></td>
										<td width="10%"><div align="right"><strong>Gender</strong></div></td>
										<td width="10%">
											<gw:list  id="lstMGender" value ="NON" styles='width:100%'onchange="" >
												<data>
													<%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0013'")%> |NON|
												</data>
											</gw:list>
										</td>
										<td width="10%">
											
										</td>
										<td width="10%">&nbsp;</td>
										<td colspan="2">
											<table>
												<tr>
													<td width="7%">&nbsp;</td>
													<td width="3%"><gw:imgBtn id="btnMAddnew" img="new" alt="Add new item" onclick="OnAddnewData('STYLE')" /></td>
													<td width="3%"><gw:imgBtn id="btnMDelete" img="delete" alt="Delete Selected item" onclick="OnDeleteData('STYLE')" /></td>
													<td width="3%"><gw:imgBtn id="btnMSave" img="save" alt="Save all changed Information" onclick="OnSaveChangedData('STYLE')" /></td>
													<td width="1%">&nbsp;</td>
												</tr>
											</table>
										</div></td>
									</tr>
									<tr>
										<td><div align="right"><strong>Style No </strong></div></td>
										<td colspan="3"><gw:textbox id="txtMStyleNo" styles="width: 100%" csstype="mandatory" /></td>
										<td width="10%"><div align="right"><strong>Style Desc </strong></div></td>
										<td colspan="5"><gw:textbox id="txtMStyleDesc" styles="width: 100%" csstype="mandatory" /></td>
									</tr>
									<tr>
										<td width="10%"><div align="right"><strong>Style Year </strong></div></td>
										<td width="10%"><gw:datebox id="datMStyleYear" onchange="" maxlen = "10" styles='width:100%'lang="<%=Session("Lang")%>"  type=year /></td>
										<td width="10%"><div align="right"><strong>Season</strong></div></td>
										<td width="10%">
											<gw:list  id="lstMStyleSeason" value ="NON" styles='width:100%'onchange="" >
												<data>
													<%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0014'")%> |NON|
												</data>
											</gw:list>
										</td>
										<td width="10%"><div align="right"><strong>Unit </strong></div></td>
										<td width="10%">
											<gw:list  id="lstMStyleUnit" value ="NON" styles='width:100%'onchange="" >
												<data>
													<%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0015'")%> |NON|
												</data>
											</gw:list>
										</td>
										<td width="10%"><div align="right"><strong>Currency</strong></div></td>
										<td width="10%">
											<gw:list  id="lstMStyleCurrency" value ="ALL" styles='width:100%'onchange="" >
												<data>
													<%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0006'")%> |NON|
												</data>
											</gw:list>
										</td>
										<td width="10%"><div align="right"><strong>Unit Price </strong></div></td>
										<td width="10%"><gw:textbox id="txtMUnitPrice" type="number" format="###,###.###" styles="width:100%;" onenterkey="" /></td>
									</tr>
									<tr>
										<td><div align="right"><strong>Remark</strong></div></td>
										<td colspan="3"><gw:textbox id="txtMStyleRemark" styles="width:100%;" onenterkey="" /></td>
										<td><div align="right"><strong>Start Date </strong></div></td>
										<td><gw:datebox id="datMStyleDateST" maxlen = "10" text="" styles='width:90%' lang="<%=Session("Lang")%>" nullaccept onchange=""/></td>
										<td><div align="right"><strong>End date </strong></div></td>
										<td><gw:datebox id="datMStyleDateEnd" maxlen = "10" text="" styles='width:90%' lang="<%=Session("Lang")%>" nullaccept onchange=""/></td>
										<td><div align="right"><strong>Active</strong></div></td>										
										<td><gw:checkbox id="optMStyleActive" defaultvalue="Y|N" value="N" /></td>
									</tr>
								</table>
<!------------------------------------------------------------------------------------------------------------------------>
							</td>
						</tr>
						<tr height="95%">
						
							<td ><gw:tab id="idTab_Detail"  onpageactivate="OnSearchTab()">
								<table name="Style Color" width="100%" height="100%" border="1">
									<tr height="5%">
										<td>
											<table width="100%" height="100%" border="0">
												<tr>
													<td width="87%">&nbsp;</td>
													<td width="3%"><gw:imgBtn id="btnDSCAddnew" img="new" alt="Add new item" onclick="OnAddnewData('STYLE_COLOR')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSCDelete" img="delete" alt="Delete Selected item" onclick="OnDeleteData('STYLE_COLOR')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSCUnDelete" img="udelete" alt="UnDelete Selected item" onclick="OnUnDeleteData('STYLE_COLOR')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSCSave" img="save" alt="Save all changed Information" onclick="OnSaveChangedData('STYLE_COLOR')" /></td>
													<td width="1%">&nbsp;</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr height="95%">
										<td>
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>
														<gw:grid   
															id="grdListDSC"  
															header="_PK|_STYLE_PK|SEQ|Color ID|Color Name|local Name|Description"
															format="0|0|0|0|0|0|0"
															aligns="0|0|0|0|0|0|0"
															defaults="||||||"
															editcol="0|1|1|1|1|1|1"
															widths="0|0|1000|2500|2500|2500|2500"
															styles="width:100%; height:100%"   
															sorting="T"   
															acceptNullDate
															param="0,1,2,3,4,5,6" onSelChange="" OnClick=""  />
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								
								<table name="Style Size" background="#BDE9FF" width="100%" height="100%" border="1">								
									<tr >
										<td>
											<table width="100%" height="100%" border="0">
												<tr>
													<td width="87%">&nbsp;</td>
													<td width="3%"><gw:imgBtn id="btnDSSAddnew" img="new" alt="Add new item" onclick="OnAddnewData('STYLE_SIZE')" /></td>
													<td width="3%"><gw:imgBtn id="btnSDelete" img="delete" alt="Delete Selected item" onclick="OnDeleteData('STYLE_SIZE')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSSUnDelete" img="udelete" alt="UnDelete Selected item" onclick="OnUnDeleteData('STYLE_SIZE')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSSSave" img="save" alt="Save all changed Information" onclick="OnSaveChangedData('STYLE_SIZE')" /></td>
													<td width="1%">&nbsp;</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr height="95%">
										<td>
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>
														<gw:grid   
															id="grdListDSS"  
															header="_PK|_TST_STYLE_PK|SEQ|Size Information|Remark"
															format="0|0|0|0|0"
															aligns="0|0|0|0|0"
															defaults="||||"
															editcol="0|1|1|1|1"
															widths="0|0|1000|4500|2500"
															styles="width:100%; height:100%"   
															sorting="T"   
															acceptNullDate
															param="0,1,2,3,4" onSelChange="" OnClick=""  />
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								
								<table name="Style Cut Part" width="100%" height="100%" border="1">
								
									<tr >
										<td>
											<table width="100%" height="100%" border="0">
												<tr>
													
													<td width="87%">&nbsp;</td>
													<td width="3%"><gw:imgBtn id="btnDSPAddnew" img="new" alt="Add new item" onclick="OnAddnewData('STYLE_CUTPART')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSPDelete" img="delete" alt="Delete Selected item" onclick="OnDeleteData('STYLE_CUTPART')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSPUnDelete" img="udelete" alt="UnDelete Selected item" onclick="OnUnDeleteData('STYLE_CUTPART')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSPSave" img="save" alt="Save all changed Information" onclick="OnSaveChangedData('STYLE_CUTPART')" /></td>
													<td width="1%">&nbsp;</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr height="95%">
										<td>
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>
														<gw:grid   
															id="grdListDSP"  
															header="_PK|_TST_STYLE_PK|SEQ|Part ID|Part Name|Position Type|Prod code|Remark|Start date|End date|Use"
															format="0|0|0|0|0|2|3|0|4|4|3"
															aligns="0|0|0|0|0|0|0|0|0|0|0"
															defaults="||||||1||||1"
															editcol="0|1|1|1|1|1|1|1|1|1|1"
															widths="0|0|500|2000|2500|2500|500|2500|1500|1500|500"
															styles="width:100%; height:100%"   
															sorting="T"   
															acceptNullDate
															param="0,1,2,3,4,5,6,7,8,9,10" onSelChange="" OnClick=""  />
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								<table name="Style Defect" width="100%" height="100%" border="1">
									<tr >
										<td>
											<table width="100%" height="100%" border="0">
												<tr>
													<td width="87%">&nbsp;</td>
													<td width="3%"><gw:imgBtn id="btnDSDAddnew" img="new" alt="Add new item" onclick="OnAddnewData('STYLE_DEFECT')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSDDelete" img="delete" alt="Delete Selected item" onclick="OnDeleteData('STYLE_DEFECT')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSDUnDelete" img="udelete" alt="UnDelete Selected item" onclick="OnUnDeleteData('STYLE_DEFECT')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSDSave" img="save" alt="Save all changed Information" onclick="OnSaveChangedData('STYLE_DEFECT')" /></td>
													<td width="1%">&nbsp;</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr height="95%">
										<td>
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>
														<gw:grid   
															id="grdListDSD"  
															header="_PK|_TST_STYLE_PK|SEQ|Defect|L Repair|Position|Remark|Start date|End date|Use"
															format="0|0|0|2|3|2|0|4|4|3"
															aligns="0|0|0|0|0|0|0|0|0|0"
															defaults="||||1|||||1"
															editcol="0|1|1|1|1|1|1|1|1|1"
															widths="0|0|500|2500|1000|2500|3000|1500|1500|500"
															styles="width:100%; height:100%"   
															sorting="T"   
															acceptNullDate
															param="0,1,2,3,4,5,6,7,8,9" onSelChange="" OnClick=""  />
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								<table name="Style Picture" width="100%" height="100%" border="1">
									<tr >
										<td>
											<table width="100%" height="100%" border="0">
												<tr>
													<td width="87%">&nbsp;</td>
													<td width="3%"><gw:imgBtn id="btnDSTAddnew" img="new" alt="Add new item" onclick="OnAddnewData('STYLE_PICTURE')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSTDelete" img="delete" alt="Delete Selected item" onclick="OnDeleteData('STYLE_PICTURE')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSTUnDelete" img="udelete" alt="UnDelete Selected item" onclick="OnUnDeleteData('STYLE_PICTURE')" /></td>
													<td width="3%"><gw:imgBtn id="btnDSTSave" img="save" alt="Save all changed Information" onclick="OnSaveChangedData('STYLE_PICTURE')" /></td>
													<td width="1%">&nbsp;</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr height="95%">
										<td>
											<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
												<tr height="100%">
													<td >
														<table width="100%" height="100%" border="1">
														  <tr>
															<td width="70%">
																<gw:grid   
																	id="grdListDST"  
																	header="_PK|_TST_STYLE_PK|SEQ|_File name|Picture"
																	format="0|0|0|0|0"
																	aligns="0|0|0|0|0"
																	defaults="||||Double click to add picture"
																	editcol="0|0|1|0|0"
																	widths="0|0|1000|3500|3000"
																	styles="width:100%; height:100%"   
																	sorting="T"   
																	acceptNullDate="T"
																	onSelChange="" onclick="SelectPicture()"  oncelldblclick="OnClickUpload()"/>
															</td>
															<td width="30%"><gw:image id="imgFile"  table_name="STM.TST_STYLEPIC" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:100%;height:100%"  /></td>
														  </tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								
								</gw:tab>
							</td>
							
						</tr>
						
						<tr>
							<td>
							</td>
						</tr>
					</table>
				</td>	
		</tr>
	</table>
	<!--------------------------------------------------------------------------->
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
	<!--------------------------------------------------------------------------->
    <gw:textbox id="txtMStyle_PK" styles='width:100%;display:none' />
    <!------------------------------------------->
</body>
</html>
