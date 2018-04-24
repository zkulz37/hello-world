<!-- #include file="../../../system/lib/form.inc" -->
<%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Card Visitor Entry</title>
</head>

<script>
var 
i_pk =0,
i_cardId =1,
i_cardName =2,
i_cardType =3,
i_status =4,
i_use_yn =5,
i_registerDt =6
i_description=7
i_color=8
i_exist=9
function BodyInit()
{ 
	<%=ESysLib.SetGridColumnComboFormat( "grdCard" , 3 , "select code,CODE_NM from vhr_hr_code where id='HR0121' order by code" ) %>; 
	
 
}
function OnSearch()
{
    dataVisitorCard.Call('SELECT');
}
function OnDataReceive(obj)
{
    if (obj.id=="dataVisitorCard")
    {
        lblRecord.text=grdCard.rows-1 + " record(s)";
        for (var i=1;i<grdCard.rows;i++)
        {
            var scolor=grdCard.GetGridData(i,i_color);
            grdCard.SetCellBgColor(i, 0,i, grdCard.cols-1,  Number(scolor));
        }
    }
    else if (obj.id=="datCardExist")
    {
        var i=1;
        var bexist=false;
        var scard_id1,scard_id2;
        while (i<grdCard.rows)
        {
            bexist=false;
            scard_id1=grdCard.GetGridData(i,i_cardId);
            if (grdCard.GetRowStatus(i)!=0)
            {
               for (var j=1;j<grdExist.rows && bexist==false;j++)
                {
                        scard_id2=grdExist.GetGridData(j,0);
                        if (scard_id2==scard_id1)
                        {
                            bexist=true;
                        }
                }
                if (bexist==true)
                    grdCard.SetGridText(i,i_exist,'Y');
                else
                    grdCard.SetGridText(i,i_exist,'N');
            }
            i++;
            
        }
    }
}
function OnAddNew()
{
    grdCard.AddRow();
    grdCard.SetGridText(grdCard.rows -1 ,i_status,'01' )
 }
function OnSave()
{
    if(confirm("Do you want to save?\nBạn muốn lưu?"))
        dataVisitorCard.Call()
}
function OnDelete()
{
    var ctrl = grdCard.GetGridControl();
    if(ctrl.SelectedRows >0)
    {
         for (i=ctrl.Rows-1;i>0;i--) 
		    {
		        if (ctrl.IsSelected(i)) 
			    {
			        if(grdCard.GetGridData( i, i_pk) == "")
				    {
				        grdCard.RemoveRowAt(i);
				    }else
				    {
				        grdCard.DeleteRowAt(i);
				    } 
				   
			    }
		    }
    }
}
function OnUnDelete()
{
   grdCard.UnDeleteRow();
}
function OnTest()
{
    var scard_list="";
    for (var i=1;i<grdCard.rows ;i++)
    {
        var scard_id=grdCard.GetGridData(i,i_cardId);
        if (grdCard.GetRowStatus(i)!=0)
            scard_list=scard_list + String(scard_id) + ",";
    }
    if (scard_list!="") 
    {
        scard_list=scard_list.substring(0,scard_list.length-1);
        txtCardIDList.text=scard_list
        datCardExist.Call("SELECT");
    }
}
</script>
<body>
   
<gw:data id="dataVisitorCard" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_visitor_card" procedure="hr.sp_upd_visitor_card" parameter="0,1,2,3,4,5,6,7"> 
                <input>
                    <input bind="lstCardType" />
                    <input bind="lstCardStatus" />
                    <input bind="txtCard" />
                    <input bind="lstExist" />
                </input>
                <output  bind="grdCard" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datCardExist" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_card_visitor_exist" > 
                <input>
                    <input bind="txtCardIDList" />
                </input>
                <output  bind="grdExist" />
            </dso> 
        </xml> 
</gw:data>

<table  cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;">
       <tr style="height:10%">
            <td style="width:9%" align=right>  Card  Type </td>
            <td style="width:10%">
                <gw:list  id="lstCardType"  maxlen = "100" value='ALL' styles='width:100%'onchange="OnSearch()" >
                    <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0121' order by code ")%>|ALL|Select All
                     </data>
                 </gw:list>
            </td>
            <td style="width:9%" align=right> Card Status </td>
            <td style="width:10%">
                <gw:list  id="lstCardStatus"  maxlen = "100" value='ALL' styles='width:100%'onchange="OnSearch()" >
                    <data> DATA|01|FREE|02|USING|ALL|Select All
                     </data>
                 </gw:list>
            </td>
            <td style="width:8%" align=right> Exist</td>
            <td style="width:8%">
                <gw:list  id="lstExist"  maxlen = "100" value='ALL' styles='width:100%'onchange="OnSearch()" >
                    <data> DATA|Y|Existed|N|Not Existed|ALL|Select All
                     </data>
                 </gw:list>
            </td>
            <td style="width:8%" align=right>ID or Name</td>
            <td style="width:12%">
                <gw:textbox id="txtCard" text="" styles='width:100%;'  onenterkey="OnSearch()" />
            </td>
            <td width="8%" align=center> <gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:blue;width:90%;font-weight: bold;font-size:12" />
  </td>
             <td width="3%" align="right">
                <gw:imgBtn id="idBtnSearch" alt="Search" img="Search"  onclick="OnSearch()" />
            </td>
             <td width="3%" align="right">
                <gw:imgBtn id="idBtnNew" alt="New" img="New"  onclick="OnAddNew()" />
            </td>
            <td width="3%" align="right">
                <gw:imgBtn id="idBtnDel" alt="Delete" img="Delete"  onclick="OnDelete()" />
            </td>
             <td width="3%" align="right">
                <gw:imgBtn id="idBtnUnDel" alt="Delete" img="UDelete"  onclick="OnUnDelete()" />
            </td>
            <td width="3%" align="right">
                <gw:imgBtn id="idBtnSave" alt="Save" img="Save"  onclick="OnSave()" />
            </td>
            <td width="3%" align="right">
                <gw:imgBtn id="idBtnTest" alt="Check" img="Test"  onclick="OnTest()" />
            </td>
       </tr>
       <tr style="height:90%">
            <td style="height:100%" colspan=15>
				<gw:grid id='grdCard'
                    header='_PK|Card No|Card Name|Card Type|Status|Use YN|Register Dt|Description|_Color|Exist'
                    format='0|0|0|0|0|3|4|0|0|0'
                    aligns='0|0|0|0|0|0|0|0|0|0'
                    defaults='|||||-1||||'
                    editcol='1|1|1|1|0|1|1|1|0|0'
                    widths='0|1500|2000|2000|1500|1000|2000|2000|0|0'
                    sorting='T'
                    styles='width:100%; height:100%'
                    />
			</td>
       </tr>
</table>
<gw:textbox id="txtStatus" styles="display:none" />
    <gw:textbox id="txtCardIDList" styles="display:none">
</gw:textbox>
    <gw:grid id='grdExist'
                    header='Card No|Exist'
                    format='0|0'
                    aligns='0|0'
                    defaults='|'
                    editcol='1|1'
                    widths='0|1500'
                    sorting='T'
                    styles='width:100%; height:400;display:none'
                    />
</body>
</html>
