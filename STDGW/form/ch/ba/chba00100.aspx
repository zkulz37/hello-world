<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var startTime,interval_time;
var dt_tmp;
var opt_value=1;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var scan_dt=6;
var w_dt_col=8;
var mapping_col=9;
var old_w_dt_col=12;
var old_mapping_col=13;

function BodyInit()
{
            DailyDT.SetEnable(1);
            FromDT.SetEnable(0);
	        ToDT.SetEnable(0);
	        Month.SetEnable(0);
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 9 , "select a.CODE,a.CODE_NM from vhr_hr_code a where a.id='HR0100' ")%>;        

}
function getDaysInMonth(yyyymm) //xac dinh thang do co bao nhieu ngay
{
   // returns the last day of a given month
    var m,y,tmpDate,checkMonth,lastDay
	
	m = Number(yyyymm.substr(4,2))-1;
		if(m==-1)
			m=Number(yyyymm.substr(5,1))-1;

	y = Number(yyyymm.substr(0,4));
	tmpDate = new Date(y, m, 28);
	checkMonth = tmpDate.getMonth();
	lastDay = 27;

    while(lastDay <= 31){
        temp = tmpDate.setDate(lastDay + 1);
        if(checkMonth != tmpDate.getMonth())
            break;
        lastDay++
    }
    return lastDay;
}
function onClickOption(n)
{   
    opt_value=n;
    switch(n)
    {
        case 1:
            DailyDT.SetEnable(1);
            FromDT.SetEnable(0);
	        ToDT.SetEnable(0);
	        Month.SetEnable(0);
	        break;
	    case 2:
	        DailyDT.SetEnable(0);
            FromDT.SetEnable(1);
	        ToDT.SetEnable(1);
	        Month.SetEnable(0);
	        break;   
	    case 3:
	        DailyDT.SetEnable(0);
            FromDT.SetEnable(0);
	        ToDT.SetEnable(0);
	        Month.SetEnable(1);
	        break;        
    }
}
function OnSearch()
{
    switch(opt_value)
    {
        case 1:
           txtFrom.text=DailyDT.value
           txtTo.text=DailyDT.value
	        break;
	    case 2:
	        txtFrom.text=FromDT.value
            txtTo.text=ToDT.value
	        break;   
	    case 3:
	        txtFrom.text=Month.value+"01"
            txtTo.text=Month.value+""+getDaysInMonth(Month.value)
	        break;        
    }
    if((opt_value==2||opt_value==3)&&idtxtTmp.text=="")
    {
        if(confirm("You should search by emp id for this case. Do you want to continous?"))
            dat_time_mapping.Call("SELECT");
            
    }
    else        
        dat_time_mapping.Call("SELECT");
}
function OnDataReceive(obj)
{
       if (obj.id=="dat_time_mapping")
       {    
          idRecord.text=idGrid.rows-1 +" Records."; 
          if(idGrid.rows>1)
          {
            idGrid.SetCellBgColor(1, w_dt_col,idGrid.rows-1, mapping_col, 0xCC9900 );
            idGrid.SetCellBold(1,w_dt_col,idGrid.rows-1,mapping_col,true); 
            auto_resize_column(idGrid,0,idGrid.cols-1,0);
          } 
       }
}       
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
function OnUpdate()
{
    var t0,t1,t2,t3,t4;
    if(confirm("Do you want to update?\nBạn chắc chắn lưu?"))
    {
        for(var i=1;i<idGrid.rows-1;i++)
        {
            t0=idGrid.GetGridData(i,scan_dt)
            t1=idGrid.GetGridData(i,w_dt_col);
            t2=idGrid.GetGridData(i,mapping_col);
            t3=idGrid.GetGridData(i,old_w_dt_col);
            t4=idGrid.GetGridData(i,old_mapping_col);
            if(t1!=t3 || t2!=t4)//co sua
            {
                
                if(t2=="")
                {
                    idGrid.SetCellBgColor(i, 0,i, idGrid.cols-1, 0x3366FF );
                    if(confirm("Rows "+i+" is empty (mapping type). Ignore this row?\nDòng "+i+" chưa nhập mapping type. Bỏ qua dòng này?"))
                        idGrid.SetRowStatus(i,0);
                    else
                        return;
                }        
                else
                {
                    if(t1=="")
                    {
                        t1=t0;
                        idGrid.SetGridText(i,w_dt_col,t0)
                        
                     }   
                    if((Number(t0)-Number(t1))>=-1 && (Number(t0)-Number(t1))<=1)
                        idGrid.SetRowStatus(i,16);
                    else
                        if(confirm("Rows "+i+" is incorrect of Work date. Ignore this row?\nDòng "+i+" nhập work date sai. Bỏ qua dòng này?"));
                }
            }
            else
            {
                if(idGrid.GetRowStatus(i)==16)
                    idGrid.SetRowStatus(i,0);
            }
            if(idGrid.GetRowStatus(i)==64)//truong hop delete
            {
                move_row(i);
            }
            
        }
        dat_time_mapping.Call();
     }  
     
    
}
function move_row(n)
{
    var arr= Array();
    var flag=0;
    var status;
    for(var i=1;i<idGrid.rows;i++)
    {
        if(idGrid.GetRowStatus(i)!=64)
        {
            status=idGrid.GetRowStatus(i);
            for(var j=0;j<idGrid.cols;j++)
            {
                arr[j]=idGrid.GetGridData(i,j);
                idGrid.SetGridText(i,j,idGrid.GetGridData(n,j));
                idGrid.SetGridText(n,j,arr[j]);
            }    
            idGrid.SetRowStatus(i,64);
            idGrid.SetRowStatus(n,status);
            return;
        }
    }
    
}

function OnDelete()
{
    if(confirm("Are you sure to delete?\nBạn chắc chắn muốn xóa"))
    {
        idGrid.DeleteRow();
    }
}
function OnUndelete()
{
    idGrid.UnDeleteRow();
}
</script>

<body>
<gw:data id="dat_time_mapping" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,6,7,8,9,12,13" function="HR.SP_SEL_TIME_MAPPING" procedure="HR.SP_UPD_TIME_MAPPING"> 
                <input bind="idGrid" >
                    <input bind="txtFrom" />
                    <input bind="txtTo" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<table style="width:100%;height:14%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	<tr style="height:7%;border:1">	
		<td colspan=2 align=right style="width:10%;border:1;color=Black" ><input type="radio" name="option_P" value="1" checked onclick="onClickOption(1)" ><font>Daily</font></td>
		<td colspan=2 align=right style="width:10%;border:1"><gw:datebox id="DailyDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:1"></td>
		<td colspan=2 align=right style="width:10%;border:0"><input type="radio" name="option_P" value="2" onclick="onClickOption(2)" ><font size=3>From</font></td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:70%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0"><font>To</font> </td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:70%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0"></td>
        <td align=right colspan=2 style="width:10%;border:0"><input type="radio" name="option_P" value="3" onclick="onClickOption(3)" ><font>Month</font> </td>
		<td align=left colspan=3 style="width:15%;border:0"><gw:datebox id="Month"  text="" styles='width:50%'lang="<%=Session("Lang")%>" type=month /></td>
		<td align=left colspan=3 style="width:15%;border:0"></td>
		
    </tr>	
    <tr style="height:7%;border:1">	
		<td colspan=2 align=right style="width:10%;border:0">Search</td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:list  id="idSearch" value="1" styles="width:95%" onChange="OnSearch()">
                <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:97%" onenterkey="OnSearch()" /></td>		
		<td colspan=1 align=right style="width:5%;border:0">Nation</td>
		<td colspan=2 align=right style="width:10%;border:0">
		    <gw:list id="lstNation" value='01' styles="width:95%">
		        <data>
		        <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
		        </data>
		    </gw:list>
		</td>
		<td colspan=4 align=center style="width:20%;border:0"></td>
		<td colspan=3 align=center style="width:15%;border:0"><gw:label id="idRecord" text="" styles="width:100%" ></gw:label></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnDelete" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnUnDelete" alt="UnDelete" img="udelete" text="UnDelete" onclick="OnUndelete()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnReport" alt="report" img="excel" text="" onclick="OnReport()" /></td>
    </tr>	
	</table>
	<table id="tbl" style="width:100%;height:86%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid
					id="idGrid"
					header="_EMP_PK|_MAPPING_PK|_TEMP_PK|_TIME_PK|EMP_ID|FULL NAME|SCAN DATE|SCAN TIME|WORK DATE|MAPPING TYPE|MAPPING TIME|SHIFT|_wd|_mapping_time"
					format="0|0|0|0|0|0|4|0|4|2|0|0|4|0"
					aligns="0|0|0|0|0|0|0|1|0|0|1|0|0|0"
					defaults="|||||||||||||"
					editcol="0|0|0|0|0|0|0|1|1|0|0|0|0|0"
					widths="1000|1000|1000|1000|1000|2500|1500|1500|1500|1500|1500|4000|0|0"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit=""
					acceptNullDate="T"
					/>
			</td>
		</tr>	
	</table>
</table>
    <gw:textbox id="txtFrom" styles="display:none"/>
    <gw:textbox id="txtTo" styles="display:none"/>
</body>
</html>

