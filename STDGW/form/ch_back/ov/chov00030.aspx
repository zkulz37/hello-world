<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
var form_type;
function BodyInit()
{
    form_type="<%=request.QueryString("showType")%>";
    //alert(form_type);
	datVisitorCompany.Call("SELECT");
}

function OnDataReceive(obj)
{
    if(obj.id=="datVisitorCompany")
        auto_resize_column(grdList,0,grdList.cols-1,0);
    
}

function OnSearchData()
{
	datVisitorCompany.Call("SELECT");
}

function OnAddnewData()
{
	for(i=1; i<grdList.rows;i++)
    {
        if (grdList.GetRowStatus(i) == 32 ) 
        {
            alert("An empty row existed ! Please input data");
			return;
        }
    }
	grdList.AddRow();
	return;
}
function OnSaveData()
{
	if(CheckDataIsValid() == false)
	{
		return;
	}
	else
	{
	    if(confirm("Do you want to save?\nBạn muốn lưu?"))
		    datVisitorCompany.Call();
	}
}

function OnDeleteData()
{
    var ctrl = grdList.GetGridControl();
    if(ctrl.SelectedRows >0)
    {
         for (i=ctrl.Rows-1;i>0;i--) 
		    {
		        if (ctrl.IsSelected(i)) 
			    {
			        if(grdList.GetGridData( i, 0) == "")
				    {
				        grdList.RemoveRowAt(i);
				    }else
				    {
				        grdList.DeleteRowAt(i);
				    } 
				   
			    }
		    }
    }
}
function OnUnDeleteData()
{
   grdList.UnDeleteRow();
}

function CheckDataIsValid() // true : it's OK; false : cannot
{
	if(CheckValidValue(grdList, 2, "", "Company name Cannot empty") == false )
	{
		return false;
	}
	return true;
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
			if(tmp.TextMatrix(i , col) == tmp.TextMatrix(j , col))
			{
				lb = ("Duplicate data at row : " + j + " with value : " + tmp.TextMatrix(j , col));
				alert(lb)
				return i;
			}
		}
    }
    return 0; // khong trung
}

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

function CheckValidValueOnCell(obj, col, row, values, msg )
{
    if(col < 0)
        return true; // Du lieu tai cot [col] trong [obj] khong trung voi [values]
    if(obj.Rows <= 1)
        return true; 
    var tmp = obj.GetGridControl();
    if(tmp.TextMatrix(row , col) == trim(values))
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
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
function onChoose_company()
{
   if(form_type=="popup")//dang popup
   {
        var obj =new Array();
        var irow=event.row;
            if (irow>0) 
            {
                obj[0]=grdList.GetGridData(irow,0); //company pk
                obj[1]=grdList.GetGridData(irow,1); //company id
                obj[2]=grdList.GetGridData(irow,2); //company name
            }    
            else 
            {
                obj=null;
            }
	        window.returnValue = obj; 
	        window.close();
   }
}


</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Visitor Company</title>
</head>
<body>

<gw:data id="datVisitorCompany" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6" function="HR.SP_SEL_VISITOR_COMPANY" procedure="HR.SP_UPD_VISITOR_COMPANY_ENTRY"> 
                <input bind="grdList" >
					<input bind="txtSearchInfo" /> 
                </input>
                <output  bind="grdList" />
            </dso> 
        </xml> 
</gw:data>

<table cellpadding="2" cellspacing="2" border=0 style="width:100%;height:100%;"> <tr width="100%"><td>
	<fieldset style="padding: 5"><legend>Thông tin tìm kiếm</legend>
			<table cellpadding="1" cellspacing="1" border=0>
				<tr style="width:100%;height:100%" valign="top">
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
				</tr>
				<tr>
					<td colspan="5" align = "right"> </td>
					<td colspan="25" align = "right">Thông tin công ty</td>
					<td colspan="35" align = "right"><gw:textbox id="txtSearchInfo" onenterkey = "OnSearchData()"/></td>
					<td colspan="2" align = "right"><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearchData()"/></td>
					<td colspan="25" align = "right"> </td>
					<td colspan="2" align="right"><gw:imgBtn id="idBtnNew" alt="Thêm mới" img="New"  onclick="OnAddnewData()" /></td>
					<td colspan="2" align="right"><gw:imgBtn id="idBtnDel" alt="Xóa" img="Delete"  onclick="OnDeleteData()" /></td>
					<td colspan="2" align="right"><gw:imgBtn id="idBtnUnDel" alt="Hồi lại" img="UDelete"  onclick="OnUnDeleteData()" /></td>
					<td colspan="2" align="right"><gw:imgBtn id="idBtnSave" alt="Lưu" img="Save"  onclick="OnSaveData()" /></td>
					
				</tr>
			</table></fieldset>
		</td>
	</tr>
	<tr width="100%" height="100%" >
		<td ><table border=1 style="width:100%;height:100%;"><tr><td width="75%"  rowspan="2">
                             <gw:grid   
                                id="grdList"  
                                header="_PK|_Mã Cty|Tên Cty|Địa chỉ|Điện thoại|Trạng thái sử dụng|Diễn giải thêm"
                                format="0|0|0|0|0|3|0" 
                                aligns="0|0|0|0|0|0|0" 
                                defaults="|||||-1|"
                                editcol="1|1|1|1|1|1|1"
                                widths="0|2000|4000|4000|1500|500|2000"   
                                styles="width:100%; height:100%" 
								acceptNullDate
                                sorting="T"    oncelldblclick="onChoose_company()" 
                                /> 
			</td></tr>
			</table>
	</td></tr>
</table>

</body>
</html>
