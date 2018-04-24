<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var startTime,interval_time
var dt_tmp
var opt_value=1
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    idGrid.GetGridControl().FrozenCols =4;
    idGrid.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);	
      iduser_pk.text = "<%=session("USER_PK")%>";
      txtHr_level.text= "<%=session("HR_LEVEL")%>";
      txtCompany_pk.text="<%=Session("COMPANY_PK")%>";
      ChangeColorItem(lstOrg.GetControl());        
     do_DisEnable(3);
	 if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        datUser_info.Call();  
     else
        onChange_org();      	    
	
}

//-----------------------------------------------
 function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }
//------------------------------------------------------------------------------------
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}
function clock(start,x) 
{
 var d = new Date()
 idInterval.text= Math.round((d.valueOf()-start)/x);
}
//------------------------------------------------------------------------------------

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
//------------------------------------------------------------------------------------
function do_Enable(n)
{
    if(n==1)
    {
        ibtnSave.SetEnable(1);  
        chkSelectAll.SetEnable(1);
    }
    else if(n==2)
    {
        idRate.SetEnable(1); 
        idBtnSet.SetEnable(1);
        idBtnClear.SetEnable(1);
    }   
    else
    {
        ibtnSave.SetEnable(1);  
        chkSelectAll.SetEnable(1);
        idRate.SetEnable(1); 
        idBtnSet.SetEnable(1);
        idBtnClear.SetEnable(1);
    }
}
//------------------------------------------------------------------------------------
function do_DisEnable(n)
{
    if(n==1)
    {
        ibtnSave.SetEnable(0);  
        chkSelectAll.SetEnable(0);
    }
    else if(n==2)
    {
        idRate.SetEnable(0); 
        idBtnSet.SetEnable(0);
        idBtnClear.SetEnable(0);
    }    
     else
    {
        ibtnSave.SetEnable(0);  
        chkSelectAll.SetEnable(0);
        idRate.SetEnable(0); 
        idBtnSet.SetEnable(0);
        idBtnClear.SetEnable(0);
    }
}
//-------------------------------------------------------------------------------

function Numbers(e) 
{ 
  //  var ctrl=idTEL.GetControl(); 
    var keynum; 
    var keychar; 
    var numcheck; 
    keynum =event.keyCode; 
        
    if(window.event) // IE 
    { 
      keynum = e.keyCode; 
    } 
    else if(e.which) // Netscape/Firefox/Opera 
    { 
      keynum = e.which; 
    } 
    keychar = String.fromCharCode(keynum); 
    numcheck = /\d/; 
    return numcheck.test(keychar); 
}
//---------------------------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj
        txtUpperDept.text=obj;
        onChange_org();
    }
    
}
//------------------------------------------------------------------------------------
function OnChangeDept()
{
    //txtDept.text=lstOrg.value;
    //datGroupData.Call();
}
//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
       if (obj.id=="datDeptData")
       {
            if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstOrg.SetDataText(txtDeptData.text)    ;
            
              obj=lstOrg.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=0;
            //datGroupData.Call();
       }
       else if (obj.id=="datGroupData")
       {
            lstOrg_Type.SetDataText(txtGroupData.text);
            var obj=lstOrg_Type.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=obj.options.length-1;
       }
       else if (obj.id=="datWorkingRate")
       {
           clear_Interval(idInterval);
           idInterval.text=idGrid.rows-1 + " records."
           if(idGrid.rows>1)
                do_Enable(1);
                
       }
       else if (obj.id=="datUser_info")
       {      
            ChangeColorItem(lstOrg.GetControl());           
            datWorkGroup_info.Call();
       }
       else if (obj.id=="datWorkGroup_info")
       {
                           
                lstWG.SetDataText(txtwg_tmp.text+'|ALL|Select All');
                lstWG.value='ALL';
                datWorkShift_info.Call();
            
       }
        else if (obj.id=="datWorkShift_info")
       {
                           
                lstWS.SetDataText(txt_WS_temp.text+'|ALL|Select All');
                lstWS.value='ALL';
                
            
       }
      
      
	   
}     
//------------------------------------------------------------------------------------
function OnSearch()
{
  set_Interval(100);  
  datWorkingRate.Call("SELECT");  
}
//------------------------------------------------------------------------------------
function OnSelectAll(obj_checkbox,obj_grd)
{	
    var ctrl=obj_grd.GetGridControl();
    if( obj_checkbox.GetData()=='T')
    {
        for(var i=1;i<ctrl.rows;i++)
            ctrl.IsSelected(i)="True";
    }
	else
	{
        for(var i=1;i<ctrl.rows;i++)
            ctrl.IsSelected(i)="False";
    }        
}
function change_list()
{
   if(idLstRate.value=="0")
    {
        do_DisEnable(2);
    }
    else
    {
        if(idGrid.rows>1)
            do_Enable(2);
    }
}
//---------------------------------------------------------------
function OnSet_Clear_Grid(act)
{
	var gCtrl,i,col;
	gCtrl=idGrid.GetGridControl();	
	switch(idLstRate.value)
	{
	    case '1'://wt
	        col=7;
	        break;
	    case '2':
	        col=9;
	        break;
	    case '3':
	        col=11;
	        break;
	    case '4':
	        col=13;
	        break;
	}
    if(gCtrl.SelectedRows>1)
    {
        if(act=='Set')
        {
            for(i=0;i<gCtrl.SelectedRows;i++)
	        {
			    var tmp=gCtrl.SelectedRow(i);	
			    if(idGrid.GetGridData(tmp,col-1)!="")
			        idGrid.SetGridData(tmp,col,idRate);	
    				
		    }
		 }
		else //Clear
		 for(i=0;i<gCtrl.SelectedRows;i++)
	        {
			    var tmp=gCtrl.SelectedRow(i);	
			        idGrid.SetGridText(tmp,col,'');	
    				
		    }
		    
    }
}
//------------------------------------------------------------------------------------
function OnUpdate()
{
    if(confirm("Do you want to save?\nBạn đã chắc chắn save?"))
        datWorkingRate.Call();
}
//------------------------------------------------------------------------------------

function OnReport()
{
    var url=System.RootURL+'/reports/ch/ba/rpt_working_rate.aspx?p_tco_org_pk='+lstOrg.value;
    url+='&p_group='+lstOrg_Type.value+'&p_ws='+lstWS.value+'&p_fromdt='+FromDT.value;
    url+='&p_todt='+ToDT.value+'&p_id_search='+idSearch.value+'&p_tmp='+idtxtTmp.text
    window.open(url);
}

function onChange_org()
{
    //if(lstOrg.value!='ALL')
        datWorkGroup_info.Call();
}

</script>

<body>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_wg_role"  > 
                <input>
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datWorkShift_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_sp_sel_ws_role"  > 
                <input>
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txt_WS_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datWorkingRate" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,7,9,11,13,14,15,16,17,18" function="HR_SEL_10020004_WRATE" procedure="HR_upd_10020004_wrate"> 
                <input bind="idGrid" >
                    <input bind="lstOrg" />
                    <input bind="lstOrg_Type" />
                    <input bind="lstWS" />
                    <input bind="FromDT" />
                    <input bind="ToDT" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstWG" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<table style="width:100%;height:16%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	<tr style="height:7%;border:1">	
		<td align=right style="width:5%;border:1" >From</td>
		<td colspan=2 align=right style="width:10%;border:1"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td align=center style="width:5%;border:1">To</td>
		<td colspan=2 align=left style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td colspan=2 align=right style="width:10%;border:0" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
		<td colspan=4 align=right style="width:17%;border:0"><gw:list  id="lstOrg"  value="ALL" styles='width:100%' onchange="onChange_org()" >
                <data>
                    <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
		<td align=right style="width:7%;border:0">Org Type</td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:list  id="lstOrg_Type"  value="ALL" styles='width:100%' >
                            <data><%= ESysLib.SetListDataFUNC("SELECT F_COMMONCODE('COEO0030','','') FROM DUAL")%>|ALL|Select All</data></gw:list>
        </td>
		<td align=right colspan=1 style="width:5%;border:0">WGroup</td>
		<td align=left colspan=2 style="width:10%;border:0">
		    <gw:list id='lstWG' style='width:100%' value='ALL'>
		        <data><%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0")%>|ALL|Select All</data>
		    </gw:list>
		</td>
		<td align=right style="width:3%;border:0"></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		<td  align=right style="width:3%;border:0" ><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
    </tr>	
    <tr style="height:7%;border:1">	
		<td align=right style="width:5%;border:0" >WS</td>
        <td colspan=6 align=right style="width:30%;border:0"><gw:list  id="lstWS" value="ALL"  maxlen = "100" styles='width:100%' onchange="">
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list>
        </td>
        <td align=right style="width:5%;border:0">Rate</td>
        <td colspan=2 align=right style="width:10%;border:0"><gw:list id="idLstRate"  styles="width:100%" value="0" onchange="change_list()"><data>|0|Choose...|1|WT Rate|2|OT Rate|3|NT Rate|4|HT Rate</data></gw:list ></td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:textbox id="idRate" maxlen = "3" styles="width:100%" onkeypress="return Numbers(event)" onenterkey="OnSet_Clear_Grid('Set')" /></td>
        <td align=right style="width:5%;border:0"><gw:icon id="idBtnSet"  styles='width:90%' img="in"  text="Set"  onclick="OnSet_Clear_Grid('Set')"/></td>
		<td align=right style="width:5%;border:0"><gw:icon id="idBtnClear"  styles='width:90%' img="in"  text="Clear"  onclick="OnSet_Clear_Grid('Clear')"/></td>
		<td align=right colspan=2 style="width:5%;border:0">Search</td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:list  id="idSearch" value="1" styles='width:100%' onChange="">
                <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list>
        </td>
         <td colspan=4 align=right style="width:15%;border:0"><gw:textbox id="idtxtTmp" maxlen = "50" styles="width:100%" onenterkey="OnSearch()" /></td>       
         
    </tr>	
    <tr style="height:2%;border:0">	
        <td align=right style="width:5%;border:1" ><gw:checkbox id="chkSelectAll" value="F" onclick="OnSelectAll(chkSelectAll,idGrid)" ></gw:checkbox ></td>
        <td colspan=2 align=left style="width:10%;border:1" >Select All</td>
        <td colspan=19 align=right style="width:85%;border:1" style="color=#FF00CC"><gw:label id="idInterval" text="0 record(s)" styles="width:100%" ></gw:label></td>
       
        
    </tr>	
	</table>
	<table id="tbl" style="width:100%;height:84%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid
					id="idGrid"
					header="_EMP_PK|ORGANIZATION|EMP_ID|FULL_NM|W_S|WORK DT|WT|WT RATE(%)|OT|OT RATE(%)|NT|NT RATE(%)|HT|HT RATE(%)|_WKD_PK|_OT_PK|_NT_PK|_HT_PK|_WD_TEMP"
					format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					aligns="0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1"
					defaults="||||||||||||||||||"
					editcol="0|0|0|0|0|0|0|1|0|1|0|1|0|1|0|0|0|0|0"
					widths="0|1500|1000|2500|5000|1400|500|1200|500|1200|500|1200|500|1200|500|800|500|800|0"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit=""
					oncellclick = ""
					acceptNullDate="T"
					param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" oncelldblclick = "Popup()"/>
			</td>
		</tr>	
	</table>
</table>

	<gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtCompany_pk" styles="display:none"/>
    <gw:textbox id="txtwg_tmp" styles="display:none"/>    	
    <gw:textbox id="txt_WS_temp" styles="display:none"/> 
</body>
</html>

