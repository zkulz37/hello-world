<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%ESysLib.SetUser("hr");%>

<script>
var mSelect,mLoaiThe;
function BodyInit()
{
	var idDsqlid  = "<%=Request["dsqlid"]%>";
	var title  = "<%=Request["popTitle"]%>";
	
	mSelect    = "<%=Request["MultiSelect"]%>";
	mLoaiThe    = "<%=Request["cardtype"]%>";
	lblTitle.text = title +"(Danh Sách Thẻ)";
    if(mLoaiThe=="")
    {
        mLoaiThe ="ALL";
    }
    lstCardType.value = mLoaiThe;
    lstCardType.SetEnable(false);
	OnSearch();
}

function OnSearch()
{
    dsoAccountT.Call("SELECT");
}

function OnCancel(clear)
{
	window.returnValue = null; 
	this.close();
}

function SelectAll()
{
	for(i=1; i<idGrid.rows; i++)
	{
		idGrid.SetGridText( i, 0, "-1" );			
	}
}

function Select()
{
	
    if(mSelect == "true")
	{
		return;
	}
	
	var code_data=new Array()
	var ctrl = idGrid.GetGridControl();
	var rowNo
	index = 1;
	rowNo = 0;
	
	if(ctrl.SelectedRows == 0)
    {
        alert("Please select an account.");
        return ;
    }
    else
	{
		rowNo = ctrl.SelectedRow(0);
		code_data[code_data.length] = idGrid.GetGridData(rowNo, 0 );//PK
		code_data[code_data.length] = idGrid.GetGridData( rowNo, 1 );//ID
		code_data[code_data.length] = idGrid.GetGridData( rowNo, 2 );//Name
		code_data[code_data.length] = idGrid.GetGridData( rowNo, 3 );//Type
		code_data[code_data.length] = idGrid.GetGridData( rowNo, 4 );//Descript
		code_data[code_data.length] = idGrid.GetGridData( rowNo, 5 );//Descript
	}
	window.returnValue = code_data; 
	this.close(); 	
}

function SelectMulti()
{
    var code_data=new Array()
	
	if(idAction == "UPDATE")
	{
		return;
	}
	
	for(i=1; i<idGrid.rows; i++)
	{
		if(idGrid.GetGridData( i, 0 ) ==  -1  )
		{
			var tmp =new Array()
			tmp[tmp.length] = idGrid.GetGridData(i, 0 );
			tmp[tmp.length] = idGrid.GetGridData( i, 1 );
			tmp[tmp.length] = idGrid.GetGridData( i, 2 );
			tmp[tmp.length] = idGrid.GetGridData( i, 3 );
			tmp[tmp.length] = idGrid.GetGridData( i, 4 );
			tmp[tmp.length] = idGrid.GetGridData( i, 5 );
			code_data[code_data.length]= tmp;
		}			
	}
	
	window.returnValue = code_data; 
	this.close(); 	
}

</script>
<body>

<gw:data id="dsoAccountT"  onreceive="" > 
    <xml> 
        <dso id="1" type="grid" function="<%=Request["dsqlid"]%>" > 
            <input bind="idGrid" >
                <input bind="txtSearchInfo"/> 
                <input bind="lstCardType"/> 
            </input> 
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data> 

    <table  border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" >
    <tr> 
        <td width="100%" height="100%">
    	    <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td align = "center"><gw:label id="lblTitle" styles='font-weight:bold;font-size:15pt;width:100%;border:1px solid #6B9EB8'/></td>
			</tr>
            <tr >
	            <td > <fieldset style="padding: 5"><legend></legend>
                    <table CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" border="0">
					<tr>
						<td width="15%" align="right"><b>Information(T.Tin Tìm Kiếm)</b></td>
						<td width="25%"><gw:textbox id="txtSearchInfo" onenterkey="OnSearch()"/></td>
						 <td style="width:10%" align=right> Card  Type(Loại Thẻ) </td>
                        <td style="width:12%">
                            <gw:list  id="lstCardType"  maxlen = "100" value='ALL' styles='width:100%'onchange="OnSearch()" >
                                <data>
                                            <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0121' order by code ")%>|ALL|Select All
                                 </data>
                             </gw:list>
                        </td>
						<td width="1%"></td>
						<td width="5%"><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
						<td ></td>
						<td width="10%" align="right"><gw:icon id="btnCancel" img="in" text="THOÁT"    styles="width:100"  onclick="OnCancel(false)" /></td> 
		            </tr>
				    </table> </fieldset>
		        </td>
	    	</tr>
		    <tr height="100%"> 
	    		<td>
	    			<table CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" border="0">
                    <tr>
			    	    <td height="80%">   
					        <gw:grid   
					            id="idGrid"  
					            header="_PK|Mã Số Thẻ|Tên Thẻ|_CardType_Code|Loại Thẻ|Ghi Chú"
					            format="0|0|0|0|0|0"
					            aligns="0|0|0|0|0|0"
					            defaults="|||||"
					            editcol="0|0|0|0|0|0"
					            widths="0|1500|2000|2000|0|1000"
					            styles="width:100%; height:100%"   
					            sorting="T"   
					            param="0,1,2,3"  
					            oncelldblclick="Select()" />
		                </td>
		            </tr>
		            </table>
            	<td>
	    	</tr>
		    </table>  
        </td>
	</tr>
    </table>
<gw:textbox id="txtItemType"              style="display:none"/>
<gw:textbox id="txtItemValue"              style="display:none"/>
<gw:textbox id="txtCompany"              style="display:none"/>

</body>
</html>