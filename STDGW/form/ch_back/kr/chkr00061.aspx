<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

function BodyInit()
{ 
	System.Translate(document);
	// Set data to combobox
	lstCategory_Data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM")%> |%|Select All";
	lstCategory.SetDataText(lstCategory_Data); lstCategory.value = "%";
	// Set Product type to grid combo
	<%=ESysLib.SetGridColumnComboFormat( "grdList" , 1 , "SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM") %>;
	ShowInfo();
	OnSearchData();
}

function OnDataReceive(obj)
{
	if(obj.id == "dsoDataList")
    {
        ShowInfo();
		return;
    }
	return;
}

function ShowInfo()
{
	lblRecordCount.text = grdList.rows - 1 + " record(s) found."
	return;
}

function OnSearchData()
{
	dsoDataList.Call("SELECT");
	return;
}

function OnSelectData()
{    
    var arr_data = new Array();
   
   if(grdList.row >0)
   {   
      for(var j=0;j<grdList.cols;j++)
         {
            arr_data[arr_data.length]= grdList.GetGridData(grdList.row ,j);
         }
         
	  if ( arr_data !=null )
	  {
		window.returnValue =  arr_data;
		window.close();
	  }
	  else
	  {
	    alert("You have not selected data yet.");
	  }
   }
}

function CheckDataIsValid()
{
	if(CheckValidValue(grdList, 1, "", "Category can not empty. You must select one in list" ) == false 
		//|| CheckValidValue(grdList, 2, "", "Training course ID can not null" ) == false
		|| CheckValidValue(grdList, 3, "", "Training course name can not null" ) == false )
	{
		return false;
	}
	else if(CheckDupplicateData(grdList,2 ) > 0)
	{
		return false;
	}
	return true;
}

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
    if(tmp.TextMatrix(row , col) == values)
	{
		alert(msg)
		return false; // Du lieu tai cot [col] trong [obj] trung voi [values]
	}
    return true; // khong trung
}

function OnDataError(obj)
{
	if (obj.id=="dsoDataList")
    {
		AlertDBError(obj.errmsg)
		return;
	}
	else
	{
		AlertDBError(obj.errmsg)
		return;
	}
}

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
    <title>Register Training Course</title>
</head>
<body>

<gw:data id="dsoDataList"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid"  function="HR_CHKR10200003_sel_Course" > 
            <input bind="grdList"  > 
				<input bind="lstCategory" /> 
				<input bind="txtFilterValue" /> 	
            </input> 
            <output bind="grdList" /> 
        </dso> 
    </xml> 
</gw:data> 

    <table width="100%" height="100%" border="1" cellspacing="0" cellpadding="0">
		<tr >
			<td>
			    <table width="100%" border="0" cellspacing="0" cellpadding="0">
			      <tr>
				    <td width="3%">&nbsp;</td>
				    <td width="60">Category :</td>
				    <td width="12%">
					    <gw:list  id="lstCategory" value = "%" styles='width:100%'onchange="OnSearchData()" >
                        </gw:list>
				    </td>
				    <td width="3%"></td>
				    <td width="150">Course ID/Name</td>
				    <td width="20%"><gw:textbox id="txtFilterValue" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData()"  /></td>
				    <td width="30%">&nbsp;</td>
				    <td width="3%"><gw:imgBtn id="btnSearch" img="search" alt="Search item" onclick="OnSearchData()" /></td>
				    <td width="3%"><gw:imgBtn id="btnSelect" img="select" alt="Search item" onclick="OnSelectData()" /></td>
			      </tr>
			    </table>
			</td>
		</tr>
		<tr >
			<td >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="15%">&nbsp;</td>
						<td width="60%" align="right"><gw:label id="lblRecordCount" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
						<td width="15%">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="90%">
			<td height="100%">
				<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<gw:grid   
								id="grdList"  
								header="_PK|Category|Course ID|Course Name|Train Time(hour)|Min Trainee|Train Course Cost|Start Date|End Date|Train Insitution|Location|_Course Local Name|_Course Foreign Name|Description"
								format="0|0|0|0|1|1|1|4|4|0|0|0|0|0"
								aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
								defaults="|||||||||||||"
								editcol="0|1|0|1|1|1|1|1|1|1|1|1|1|1"
								widths="0|2000|2000|3000|1500|1500|2000|1500|1500|3000|3000|2000|2000|2000"
								styles="width:100%; height:100%"   
								sorting="T"   
								acceptNullDate
								param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" oncelldblclick="OnSelectData()" OnClick=""  />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
