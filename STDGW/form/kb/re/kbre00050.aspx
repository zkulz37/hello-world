<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>BLOWING Result</title>
</head>

<script type="text/javascript" language="javascript">

var G2_PK           = 0,
    G2_WI_M_PK      = 1,
    G2_WI_NO        = 2, 
    G2_STATUS       = 3,
    G2_WORK_DT       = 4,
    G2_TLG_WORK_SHIFT_PK         = 5,
    G2_FROM_DT      = 6,
    G2_FROM_TIME    = 7, 
    G2_TO_DT        = 8, 
    G2_TO_TIME      = 9, 
    G2_WORK_TIME    = 10, 
    G2_DESC         = 11;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
    //----------------------------
     var ctrl = grdBlow.GetGridControl();        
     ctrl.ColFormat(G2_WORK_TIME)    = "###,###,###.##" ;   
      
     ctrl.ColEditMask(G2_FROM_TIME) = "99:99";
     ctrl.ColEditMask(G2_TO_TIME)   = "99:99"; 
  
   var data = "<%=ESysLib.SetListDataSQL(" select null,null shift from dual union all SELECT PK, shift || ' : ' || start_time || ' -> ' || end_time FROM thr_work_shift WHERE DEL_IF = 0 AND USE_YN = 'Y' order by shift nulls first ")%>";
    lst_Shift.SetDataText( data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL(" select null,null shift from dual union all SELECT PK, shift || ' : ' || start_time || ' -> ' || end_time FROM thr_work_shift WHERE DEL_IF = 0 AND USE_YN = 'Y' order by shift nulls first " ) %> ";       
    grdBlow.SetComboFormat( G2_TLG_WORK_SHIFT_PK, data); 
    
    data = "<%=ESysLib.SetGridColumnDataSQL(" select 0,'PREPARATION' from dual union all  select 1,'WAITING' from dual union all select 2,'OPERATION' from dual union all select 3,'FINISH' from dual" ) %> ";       
    grdBlow.SetComboFormat( G2_STATUS, data); 
    
     var objToday = new Date();
    curHour = objToday.getHours() < 10 ? "0" + objToday.getHours() : objToday.getHours();
    curMinute = objToday.getMinutes() < 10 ? "0" + objToday.getMinutes() : objToday.getMinutes();
    txtHH.text = curHour +":"+curMinute;
    txtHH1.text = curHour +":"+curMinute;
    startInterval();
  
}
    function startInterval()
    {
         interval = setInterval("startTime();", 60000);
    }    
    function startTime()
    {
         var objToday = new Date();
        curHour = objToday.getHours() < 10 ? "0" + objToday.getHours() : objToday.getHours();
        curMinute = objToday.getMinutes() < 10 ? "0" + objToday.getMinutes() : objToday.getMinutes();
        txtHH.text = curHour +":"+curMinute;
        txtHH1.text = curHour +":"+curMinute;
    }
//--------------------------------------------------------------------------------------------------
function OnPopUp()
{
     var path = System.RootURL + '/form/kb/al/kbal00021.aspx?p_month=' +dtMonth.value + '&p_item_cd='+grdRatio.GetGridData(grdRatio.row,G2_ITEM_CD);
     var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
           
} 
//-------------------------------------------------------------------------------------
function OnSearch()
{
    data_kbre00050.Call("SELECT");   
           
}
function OnSave()
{
    data_kbre00050.Call();
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {   
         case "data_kbre00050":	
             lblRecord.text  = ( grdBlow.rows -1 )+ " record(s)."
//             for(var i =1; i<grdBlow.rows; i++)	
//             {
//                grdBlow.GetGridControl().ColHidden(G2_ITEM_CD+i) = false;
//                grdBlow.SetGridText(0,G2_ITEM_CD+i,grdBlow.GetGridData(i,GT_NM));
//             } 
//             for (var j = grdBlow.rows + 2 ; j<= 17; j++)
//             {
//                grdBlow.GetGridControl().ColHidden(j) = true;
//             }
//             data_kbal00020.Call("SELECT");    
         break; 
	case "pro_kbre00050":
		alert(txtReturnValue.text);
	break;
        
    }
}
function SetTime()
{
    if(grdBlow.row >0)
    {
        grdBlow.SetGridText(grdBlow.row,G2_TLG_WORK_SHIFT_PK,lst_Shift.value);
        grdBlow.SetGridText(grdBlow.row,G2_FROM_DT,dt_Date.value);
        grdBlow.SetGridText(grdBlow.row,G2_FROM_TIME,txtHH1.text);
        
        grdBlow.SetGridText(grdBlow.row,G2_WORK_DT,dt_Date.value);
        
        if(grdBlow.row > 1 && grdBlow.GetGridData(grdBlow.row - 1,G2_TO_TIME) =="" )
        {
             grdBlow.SetGridText(grdBlow.row -1,G2_TO_TIME,txtHH1.text);
             grdBlow.SetGridText(grdBlow.row,G2_TO_DT,dt_Date.value);
        }
    }else
    {
        alert("Please, select a WI to set Start Time!");
    }
}
//====================================================================================
 function CheckInput()
 {
    var col = event.col;
    if ( col == G2_FROM_TIME || col == G2_TO_TIME )
	{
		tmpIN = grdBlow.GetGridData(event.row,col)
		
		if ( tmpIN.length == 0 )
		{
			grdBlow.SetGridText(event.row, col, "")
			
		}
		if( ( tmpIN.length !=4 ) && ( tmpIN.length !=0 ) )
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKi?u gi? in nh?p không ?úng")
			grdBlow.SetGridText(event.row,col,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKi?u gi? in ph?i >=00 và <=23")
			grdBlow.SetGridText(event.row,col,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKi?u phút ph?i >=00 và <=59")
			grdBlow.SetGridText(event.row,col,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdBlow.SetGridText(event.row,col,tmpIN)
		}    
	}
 
 }   
 //========================================================================================
 function OnProcess()
 {
    if(grdBlow.row >0)
    {
        txtMasterPK.text = grdBlow.GetGridData(grdBlow.row,G2_PK);
        pro_kbre00050.Call();
    }else
    {
        alert("Please, Select an finish WI to confirm!")
    }
 }  
</script>

<body>
     <!------------------------------------------------------------------>
    <gw:data id="data_kbre00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_kbre00050" parameter="0,1,2,3,4,5,6,7,8,9,10,11" procedure="<%=l_user%>lg_upd_kbre00050" > 
                <input>
                    <input bind="dt_WIDate_F" />                     
                     <input bind="dt_WIDate_T" /> 
                </input> 
                <output bind="grdBlow" /> 
            </dso> 
        </xml> 
    </gw:data>
     <!--------------------------process- wip------------------------------------->
    <gw:data id="pro_kbre00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbre00050" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------->
    <table border="0" style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width:10%">
                WI Date
            </td>
            <td style="width: 15%">
                <gw:datebox id="dt_WIDate_F" lang="<%=Application("Lang")%>" mode="01"/>
            </td>
            <td style="width: 5%">
                ~
            </td>
            <td style="width: 15%">
                <gw:datebox id="dt_WIDate_T" lang="<%=Application("Lang")%>" mode="01"/>
            </td>
             <td style="width:5%">
                Time
            </td>
            <td style="width:15%">
                <gw:textbox id="txtHH" styles="width:100%;"  />               
            </td>
             <td style="width: 5%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 30%" colspan=3 align="center">
                <gw:label id="lblRecord" text="" styles="color:red"  />
            </td>   
        </tr>
        <tr style="background-color:Aqua" >           
             <td style="width:10%">
                Blowing Date
            </td>
            <td style="width: 15%">
                <gw:datebox id="dt_Date" lang="<%=Application("Lang")%>" mode="01"/>
            </td>
             <td style="width: 5%">
                Shift
            </td>
             <td style="width: 15%" align="right">
                <gw:list id="lst_Shift" styles="width:100%;" />
            </td>
            <td style="width:5%">
                Time
            </td>
            <td style="width:15%">
                <gw:textbox id="txtHH1" styles="width:100%;" />               
            </td>
            
            <td style="width:5%">
                 <gw:icon id="idBtnSet" img="2" text="Set Time" styles='width:100%' onclick="SetTime()" />
            </td>  
            
            <td style="width: 20%"></td>
            <td style="width:5%">
                 <gw:icon id="idBtnSave" img="2" text="Save" styles='width:100%' onclick="OnSave()" />
            </td>  
            <td style="width:5%">
                 <gw:icon id="idBtnSConfirm" img="2" text="Confirm" styles='width:100%' onclick="OnProcess()" />
            </td>  
        </tr>
       
        <tr style="height: 95%">
            <td colspan="10">
                <gw:grid id='grdBlow'
                    header='_PK|_tlg_wi_line_m_pk|WI NO|Status|Blow date|Shift|From DT|Time|To DT|Time|Work Time|Description'                
                    format='0|0|0|0|4|0|4|0|4|0|0|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0'
                    check='||||||||||'
                    editcol='0|0|0|0|1|1|1|1|1|1|1|1'
                    widths='0|0|1500|1500|2000|1200|1000|1200|1000|1000|2000|0'
                    sorting='F'
                    onafteredit = "CheckInput()"
                    styles='width:100%; height:100%'
                    />
            </td>
        </tr>
    </table>
</body>

<gw:textbox id="txtMasterPK" text="" style="display: none" />
<!--------------------------------------------------------------------------->
<gw:textbox id="txtReturnValue" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
</html>