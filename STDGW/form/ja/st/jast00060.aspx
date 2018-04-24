<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Student</title>
     <%  ESysLib.SetUser("CRM")%>

<script>
function BodyInit()
{

	Binding();
	OnSearch();
}
function Binding()
{
     var ctrl = grdGolfer.GetGridControl();
     ctrl.FrozenCols = 5;
     ctrl.ColEditMask(6) = "##:##";   
     //ctrl.ColEditMask(13) = "##:##";   
     ctrl.ColEditMask(14) = "##:##";   
     ctrl.ColEditMask(15) = "##:##";   
     ctrl.ColEditMask(16) = "##:##";   
     ctrl.ColEditMask(17) = "##:##";
     ctrl.ColEditMask(18) = "##:##";
     
     var data ="#4.5;4.5|#9;9|#18;18|#27;27|#36;36|#45;45|#54;54|#;";
	 grdGolfer.SetComboFormat(19, data);
	 grdGolfer.SetComboFormat(20, data);
	 grdGolfer.SetComboFormat(21, data);

	 data = "<%=ESysLib.SetListDataSQL(" SELECT    pk, grp_cd || ' - ' || grp_nm  FROM comm.tco_itemgrp  WHERE del_if = 0 and GRP_CD in('XC','XD')   CONNECT BY PRIOR pk = p_pk  START WITH p_pk is null") %>||Please, choose group.";     
    lstItemGroup.SetDataText(data); 
	lstItemGroup.value=""; 
	var lstHoles ="#4.5;4.5|#9;9|#18;18|#27;27|#36;36|#45;45|#54;54";
    grdGolferFree.SetComboFormat(8,lstHoles);
	//data = "<%'=ESysLib.SetGridColumnDataSQL("select teetime,  teetime  from crm.tcm_teetime_sheet where mm like to_char(sysdate, 'mm') and del_if = 0 and golf_type = 1 and use_yn = 'Y' order by 1")%>";     
	//grdGolfer.SetComboFormat(13,data);
}
function CheckStartTimeLessThanEndTime(col)
{   
    var hh,mm;   
    var s = grdGolferScore.GetGridData(grdGolferScore.row,col);   
    if(s == ""){
        return;
    }
    a = s.split(":");   
    hh = Number(a[0]);  
    mm = Number(a[1]);  
    if(hh > 24){
        alert("Hour must be smaller or equal to 24.");
        return;
    }	
    if( mm > 59){
        alert("Minute must be smaller or equal to 59.");
        return;
    }      
    if(hh < 10) 
        hh="0"+hh;
    if(mm < 10) 
        mm="0"+mm;
	
    grdGolferScore.SetGridText(grdGolferScore.row,2,hh+":"+mm );
	
    return true;
}   
function OnAfterEditTime()
{
    CheckStartTimeLessThanEndTime();
}

function OnSearch(){
    dso_grdGolfer.Call("SELECT");
}
function CheckDataIsValid() 
        {
          for(var i=1;i<grdGolferFree.rows;i++)
          {
             if(grdGolferFree.GetGridData(i,8) == "")
             {
                alert("Please input holes row at "+i);
                return false;
             }
          }
          return true;
        }
var _action="";        
function OnSave(pos)
{
    switch (pos)
    {
        case 'Master':
            dso_grdGolfer.Call();
        break;
		case 'Detail2' :
			if(CheckDataIsValid())
			{
			    _action = "SAVE"; 
				dso_grdGolferFree.Call();
			} 
        break;
    }
}
function OnLookupCaddy(p_caddie_no)
{
         var path = System.RootURL + "/form/ja/rc/jarc0010_caddy.aspx?caddie_no="+p_caddie_no;
         var object = System.OpenModal( path ,700 , 400 ,  'resizable:yes;status:yes');
         if ( object != null )
         {
              var arrTemp = object[0];
              grdGolfer.SetGridText(grdGolfer.row,7,arrTemp[0]);//caddy pk
              grdGolfer.SetGridText(grdGolfer.row,8,arrTemp[1]);//caddy Id
              grdGolfer.SetGridText(grdGolfer.row,9,arrTemp[2]);//caddy name
         }
}
function OnPopupCaddy()
{
    
    if(event.col == 8 || event.col == 9)
    {
         var path = System.RootURL + "/form/ja/rc/jarc0010_caddy.aspx";
         var object = System.OpenModal( path ,700 , 400 ,  'resizable:yes;status:yes');
         if ( object != null )
         {
              var arrTemp = object[0];
              grdGolfer.SetGridText(grdGolfer.row,7,arrTemp[0]);//caddy pk
              grdGolfer.SetGridText(grdGolfer.row,8,arrTemp[1]);//caddy Id
              grdGolfer.SetGridText(grdGolfer.row,9,arrTemp[2]);//caddy name
         }
     }
}
function OnDataReceive(obj)
{
    if(obj.id == "dso_grdGolfer"){
        lblRows.text = "" + grdGolfer.rows-1;
    }
	else if(obj.id == "dsoCreateNewGroup"){
		alert("New group is " + txtReturnMsg.text);
	}
	else if(obj.id == "dsoLookupCaddie"){
	    if(grdCaddieList.rows == 2){
	          grdGolfer.SetGridText(grdGolfer.row,7,grdCaddieList.GetGridData(1,0));//caddy pk
              grdGolfer.SetGridText(grdGolfer.row,8,grdCaddieList.GetGridData(1,1));//caddy Id
              grdGolfer.SetGridText(grdGolfer.row,9,grdCaddieList.GetGridData(1,2));//caddy name
	    }
	    else{
	        OnLookupCaddy(txtTmpCaddieNo.text);
	    }
	}
	else if(obj.id == "dso_grdGolferFree"){
	    if( _action == "SAVE" ){
	        //dso_grdGolfer.Call("SELECT");
	    }
	    _action="";
	}
}
function OnChangeGroup()
{
    if(event.col == 1 && event.row >0)
    {
         var path = System.RootURL + "/form/ja/st/jast00060_change_group.aspx";
	         var object = System.OpenModal( path ,650 , 300 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            var arrTemp
	              arrTemp = object[0];
	              grdGolfer.SetGridText(grdGolfer.row,2 ,arrTemp[0]);//tgm_visitorfee_pk
	              grdGolfer.SetGridText(grdGolfer.row,1,arrTemp[3]);//group
	         }
    }  
}
function OnGridAfterEdit(){
    if(event.col == 8){
        txtTmpCaddieNo.text = grdGolfer.GetGridData(grdGolfer.row,8);//caddy Id
        dsoLookupCaddie.Call("SELECT");
    }
}
function OnNewGroup(){

	if(grdGolfer.row > 0){
		
		txtTGM_VISITORFEE_GOLFER_PK.text = grdGolfer.GetGridData(grdGolfer.row,0);
		
		if(confirm("Do you want to create new group from group "+ grdGolfer.GetGridData(grdGolfer.row,1)))
		{
			dsoCreateNewGroup.Call();
		}
    }
	else{
		alert("Please select a golfer to create new group.");
		return;
	}
}

function OnSearchItemGroup()
{
    dso_jams0040_popup_item.Call("SELECT");
}
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == 'grdItemMenu' && event.row > 0)
      {
           var col_val = oGrid.GetGridData(event.row,2);
            
            if(event.row > 0 && ( !CheckDataExist(grdGolferFree,col_val)) )
            {
                if(txtMasterPK.GetData() !="")
                {
                    SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		            grdGolferFree.AddRow();
		            for(var i=0;i<oGrid.cols-1;i++)
		            {
		              grdGolferFree.SetGridText(grdGolferFree.rows-1,i+2,oGrid.GetGridData(event.row,i));
		              grdGolferFree.SetGridText(grdGolferFree.rows-1,1,txtMasterPK.GetData());
		            }
		        }
		        else
		        {
		            alert("Please,Select the item in Master");
		        }
            }
      }
}
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, 2) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
function CheckDataExist(p_oGrid,p_value)
{
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, 4) == p_value)
              {
                 return true;
              }
       }
       return false;
}
function GridOnCellClick()
{
    if ( grdGolfer.row > 0 )
        {
            txtMasterPK.text = grdGolfer.GetGridData( event.row, 0);  
            if(grdGolfer.GetGridData(grdGolfer.row, 0)!="")
            {
                txtPlayer.text=grdGolfer.GetGridData( event.row, 3); //player
                txtLocker.text=grdGolfer.GetGridData( event.row, 4); //locker#
                txtBagtag.text=grdGolfer.GetGridData( event.row, 5);//bagtag#
                dso_grdGolferFree.Call("SELECT");
            }             
        }
 }
 function OnDelete(obj)
{
    switch (obj)
	{
		case '2':
		    
		    if(grdGolferFree.row =='-1')
		    {
		        alert("Please select item of the Golfer to delete.");
                return false;
		    }
		    else
		    {
		        if(grdGolferFree.GetGridData( grdGolferFree.row, 0) != "")
		        {
		            grdGolferFree.DeleteRow();
                    if(confirm("Do you want to delete this item?"))
                    {
                        dso_grdGolferFree.Call();
                    } 
		        }
		        else
		        {
		            grdGolferFree.RemoveRowAt(grdGolferFree.row);
		        }
		    }
		    
		break;
    }
}
function OnCalculateAllFee(){
     if(confirm("Do you want to recalculate all fees?")){
		grdGolfer.SetAllRowStatusModify();
		dso_grdGolfer.Call();
	 }
      
}
</script>

</head>
<body>
<gw:data id="dsoLookupCaddie" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2" function="crm.sp_sel_jast00060_lkp_caddie" >  
                <input bind="grdCaddieList" >  
                    <input bind="txtTmpCaddieNo" /> 	 															
                </input> 
                <output bind="grdCaddieList" /> 
            </dso> 
        </xml> 
    </gw:data> 
 <gw:data id="dso_grdGolfer" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2,4,7,13,14,15,16,17,19,20,21" function="crm.sp_sel_jast00060" procedure="CRM.sp_upd_jast00060" >  
                <input bind="grdGolfer" >  
                    <input bind="dtfr" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtName" /> 	 															
                </input> 
                <output bind="grdGolfer" /> 
            </dso> 
        </xml> 
    </gw:data> 

<gw:data id="dsoCreateNewGroup" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process"  procedure="CRM.sp_pro_jast00060" >  
                <input bind="grdGolfer" >  
                    <input bind="txtTGM_VISITORFEE_GOLFER_PK" /> 
                </input> 
                <output bind="grdGolfer" > 
				    <output bind="txtReturnMsg" />
				</output>
            </dso> 
        </xml> 
    </gw:data> 
	<!---------------grid2------->
	<gw:data id="dso_jams0040_popup_item" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_jams0040_popup_item"> 
                <input bind="grdItemMenu" > 
                     <input bind="lstItemGroup" /> 
					 <input bind="txtItem" /> 
                </input> 
                <output bind="grdItemMenu" />  
            </dso> 
        </xml> 
    </gw:data>
	 <gw:data id="dso_grdGolferFree" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="crm.sp_sel_jams0040_2" procedure="CRM.sp_upd_jams0040_2">  
                <input bind="grdGolferFree" >  
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdGolferFree" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%" style="height:100%">
        <tr style="height: 2%">
            <td style="width: 5%" >
                Date</td>
            <td style="width: 8%" >
                <gw:datebox id="dtfr"  lang="1" onchange="OnSearch()" />
            </td>
            <td style="width: 2%">~</td>
            <td style="width: 8%" >
                <gw:datebox id="dtTo"  lang="1" onchange="OnSearch()" />
            </td>
            <td  style="width: 5%"></td>
            <td style="width: 17%" align="right">
                Name/Locker#</td>
            <td style="width: 15%" >
                <gw:textbox id="txtName" onenterkey="OnSearch()" />
            </td>
            <td  style="width: 5%"></td>
            <td style="width: 14%">Total Player:</td>
            <td style="width: 5%"><gw:label id="lblRows" /> </td>
			<td style="width:4%">
                <gw:icon id="btnCalculate" text="Recalculate all fees" onclick="OnCalculateAllFee()" />
            </td>
            <td  style="width: 3%"></td>
            <td style="width: 3%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
			<td style="width:3%">
                <gw:icon id="btnNewGroup" text="New Group" onclick="OnNewGroup()" />
            </td>
            <td style="width:3%">
                <gw:imgbtn id="btnSaveMaster" img="save" alt="Save" onclick="OnSave('Master')" />
            </td>
        </tr>
        <tr style="height: 61%">
            <td colspan="15">
                <gw:grid 
                    id="grdGolfer"
                    header="_PK|Grp#|_tgm_visitorfee|Player Name|Locker#|Bagtag#|Tee Time|_Caddie_PK|CD#|Caddie Name|Cart Fee|Golfbag|Other|Start Time|Cross 1st|Cross 2nd|Cross 3rd
                    |Finish Time|Total Time|Out Course|In Course|E9 Course|Book Cart|Book Golfbag" 
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|3"
                    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    editcol="0|1|0|0|0|0|1|1|1|0|0|0|0|1|1|0|0|1|1|1|1|1|1|1" 
                    sorting='T' autosize='T'
	                styles="width:100%; height:100%"
	                oncelldblclick="OnChangeGroup()"
	                onafteredit="OnGridAfterEdit()"
					oncellclick="GridOnCellClick()"
                    />
            </td>
        </tr>
          <tr style="height: 35%" id="idfree">
            <td colspan="15">
                <table style="height: 100%"; width="100%">
                    <tr style="height: 2%">
                        <td width="10%">
                            Group
                        </td>
                        <td width="17%">
                            <gw:list id="lstItemGroup" styles='width:100%' onchange="OnSearchItemGroup()" />
                        </td>
						<td width="15%">
                            Item<gw:textbox id="txtItem"  styles="width:70%" onenterkey="OnSearchItemGroup()" />
                        </td>
                        <td width="22%">
                            Player<gw:textbox id="txtPlayer"  styles="width:70%" />
                        </td>
                        <td with="15%">
                            Locker# <gw:textbox id="txtLocker" styles="width:45%" /> 
                        </td>
                        <td with="18%">
                        Bagtag# <gw:textbox id="txtBagtag" styles="width:45%" />
                        </td>
                        <td with="3%" align="right">
                            <gw:imgbtn id="btnDeletefree" img="Delete" alt="Delete Free" onclick="OnDelete('2')" />
                        </td>
                        <td with="3%">
                            <gw:imgbtn id="btnSavefree" img="Save" alt="Save Free" onclick="OnSave('Detail2')" />
                        </td>
                    </tr>
                    <tr style="height:98%"> 
                        <td colspan="3">
                            <gw:grid id='grdItemMenu' header='_PK|Item Group|Item Code|Item Name|Unit|_Price|_Qty|_Amt'
                            format='0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0' defaults='|||||||'
                            editcol='0|0|0|0|0|0|0|0' widths='0|0|0|0|0|0|0|0'
                            autosize="T" sorting='F' acceptnulldate="T" 
                            styles="width:100%;height:100%" oncelldblclick="OnGridCellDoubleClick(this)" />
                        </td> 
                        <td colspan="10">
                            <gw:grid id="grdGolferFree" header="_PK|_PK_golfer|_item_pk|Item Group|Item Code|Item Name|Unit|Price|Holes|Qty|Amt"
                                format="0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|0|0|0" defaults="||||||||||" editcol="0|0|0|0|0|0|0|0|1|1|0"
                                widths="0|1500|2000|1000|1200|3000|1000|1000|1000|1000|1000" sorting='T' autosize='T'
                                styles="width:100%; height:100%" onafteredit="AmountSum()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <!--end--->
    </table>
	<gw:textbox id="txtMasterPK" style="display: none" />
	<gw:textbox id="txtTGM_VISITORFEE_GOLFER_PK" styles="display:none" />
	<gw:textbox id="txtReturnMsg" styles="display:none" />
	<gw:textbox id="txtTmpCaddieNo" styles="display:none" />
	 <gw:grid id="grdCaddieList" header="caddie_pk|caddie_no|caddie_name" 
         format="0|0|0" sorting='T'   styles="width:100%; height:100%;display:none"
     />
</body>
</html>
