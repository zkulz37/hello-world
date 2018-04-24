<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">        
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>"; 
var iFactor=1;
function BodyInit()
{     
    if (v_language!="ENG")
        System.Translate(document); 
    txtEmp_PK.text="<%=session("EMPLOYEE_PK")%>";
    txtCompany_PK.text="<%=session("COMPANY_PK")%>";
    txtLang.text="<%=session("SESSION_LANG")%>";  
    //SetGridFormat();    
    //merge();
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 AND NVL(CLOSE_YN,'N')='N' order by 2 desc")%>";
    lstYear.SetDataText(ls_data); 
    ls_eva_grp_data="<%=ESysLib.SetListDataSQL("select a.pk, a.GROUP_ID|| '-' || a.GROUP_NM from THR_EVA_GROUP a where a.DEL_IF=0")%>"
    ls_eva_grp_data=ls_eva_grp_data+"|ALL|Select All"
    lstEvaGrp.SetDataText(ls_eva_grp_data);
    lstEvaGrp.value="ALL";
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 6 ,  "select code,CODE_NM from vhr_hr_code where id='HR0112'  order by seq") %>; 
    imgEmp.SetEnable(0); 
    lstEvaGrp.SetEnable(0); 
    ibtnAddNew.SetEnable(1);
    ibtnDelete.SetEnable(1);
    ibtnSave.SetEnable(0);  
    idGrid.GetGridControl().FrozenCols =5;
    idGrid.GetGridControl().ScrollTrack=true;   
    dat_get_emp_info_chem00060.Call(); 
}
function SetControlStatus()
{
    txtName.SetEnable(0);    
    txtDept.SetEnable(0);
    txtGroup.SetEnable(0);
    txtPos.SetEnable(0);
    txtPos_Time.SetEnable(0);
    txtSchedule.SetEnable(0);
    txtEvalPeriod.SetEnable(0);
    
}
function ChoseList_box(obj_list,value)
{
    
    obj_list.SetDataText(value);
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1; 
	
}
function search(value,obj)
{
    ctrl=obj.GetGridControl();
    if (ctrl.rows>1)
    {       
        for (i=2;i<ctrl.rows;i++)
        {
            if (value==obj.GetGridData(i,11))
            {
              return true;
            }               
        }        
     }
     return false;
}

function SetGridFormat()
{
       if(idGrid.rows <2)
       {
            idGrid.AddRow();
       } 
        var fg=idGrid.GetGridControl();
        //set bold
        fg.Cell(13, 0, 0, 0, fg.Cols-2) = true;
		fg.Cell(13, 0, 0, 1, fg.Cols-2) = true;
        fg.FixedRows = 2;
        fg.MergeCells = 5;
		fg.MergeRow(0) = true;

		fg.MergeCol(0) = true;
		fg.Cell(0, 0, 0, 1, 0) = "Type";
		
		fg.MergeCol(1) = true;
        fg.Cell(0, 0, 1, 1, 1) = "Element";
		fg.MergeCol(2) = true;
		fg.Cell(0, 0, 2, 1, 2) = "E.Weight";
		fg.MergeCol(3) = true;
        fg.Cell(0, 0, 3, 1, 3) = "MBO Plan";
		fg.MergeCol(4) = true;
		fg.Cell(0, 0, 4, 1, 4) = "Weight";
		fg.Cell(0, 0, 3, 0, 4) = "MBO";
		
		fg.Cell(0, 0, 5, 0, 8) = "Indicator";  		
		
		fg.Cell(0, 1, 5, 1) = "Description";
		fg.Cell(0, 1, 6, 1) = "Unit";
		fg.Cell(0, 1, 7, 1) = "Current";
		fg.Cell(0, 1, 8, 1) = "Target";	
		
		fg.ColWidth(0)=800;
		fg.ColWidth(1)=2000;
		fg.ColWidth(2)=1000;
		fg.ColWidth(3)=5000;
		
		fg.ColWidth(4)=1000;
		fg.ColWidth(5)=2000;
		fg.ColWidth(6)=800;
		fg.ColWidth(7)=800;
		fg.ColWidth(8)=800;
		fg.ColWidth(9)=800;
		fg.ColWidth(10)=800;
		fg.ColWidth(11)=800;
		fg.ColAlignment(0) = flexAlignCenterCenter;
		fg.ColAlignment(4) = flexAlignRightCenter;
		fg.ColAlignment(6) = flexAlignCenterCenter;		
		fg.ColAlignment(7) = flexAlignRightCenter;
		fg.ColAlignment(8) = flexAlignRightCenter;		
}
function IsNumeric(sText)
{
   var ValidChars = "0123456789.";
   var Char;

   for (i = 0; i < sText.length; i++) 
   { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
      {
         return false;
      }
   }
   return true;
}

function checkNumberInvalid()
{  
    if (IsNumeric(idGrid.GetGridData(idGrid.row,6))==false)
    {
        alert("Value of MBO Weight must be numeri.");
        return false;
     }         
    if (IsNumeric(idGrid.GetGridData(idGrid.row,9))==false)
    {
        alert("Value of current must be numeric.");
        return false;
     }  
    if (IsNumeric(idGrid.GetGridData(idGrid.row,10))==false)
    {
        alert("Value of target must be numeric.");
        return false;
     }
     
     return true;    
}
var arrTemp;
function checkMBOWeightIsValid(){
    arrTemp = new Array();
    var ele_weight=0, mbo_weight=0;
    for (var i=2;i<idGrid.rows;i++)
    { 
      if(idGrid.GetRowStatus(i) < 64){
        if(IsNotIn(idGrid.GetGridData(i,10))){
            ele_weight += Number(idGrid.GetGridData(i,2));
            arrTemp[arrTemp.length] = idGrid.GetGridData(i,10);
        }
        mbo_weight += Number(idGrid.GetGridData(i,4));
      }
    }
    if(ele_weight != mbo_weight) {
        alert("Total element weight must be equal to total mbo weight."+ele_weight+":"+mbo_weight);
        return false;
    }
    return true;
}
function IsNotIn(key){
    for (var i=0;i<arrTemp.length;i++)
    {
        if(arrTemp[i] == key){
            return false;
        }
    }
    return true;
}
function checkdata()
{
    var i;
    var ctrl=idGrid.GetGridControl();
    
    for (i=2;i<idGrid.rows;i++)
    {   
        if(idGrid.GetRowStatus(i) > 48 )continue;
        
        if(idGrid.GetGridData(i,0) == "C") continue;
              
        if(idGrid.GetGridData(i,3)=="")
        {
            alert("Please input MBO Plan at row " + (i-1) + " !");
            return false;
        }
        if(idGrid.GetGridData(i,4)=="")
        {
            alert("Please input weight of MBO at row " + (i-1) + " !");
            return false;
        } 
        /*
        if(idGrid.GetGridData(i,5)=="")
        {
            alert("Please input description at row " + (i-1) + " !");
            return false;
        }
        if(idGrid.GetGridData(i,6)=="")
        {
            alert("Please input unit at row " + (i-1) + " !");
            return false;
        }
        if(idGrid.GetGridData(i,7)=="")
        {
            alert("Please input score at row " + (i-1) + " !");
            return false;
        }      
        if(idGrid.GetGridData(i,8)=="")
        {
            alert("Please input target  at row " + (i-1) + " !");
            return false;
        }  
        */
    }
    if(!checkMBOWeightIsValid()) return false;
     return true;
}
function OnDataReceive(obj)
{    
    if (obj.id == "dat_get_emp_info_chem00060"){        
        imgEmp.SetDataText(txtPhoto_PK.text);
        datchem00050_1.Call();
    }    
    else if (obj.id == "datchem00050_1"){        
        datchem00060_5.Call();               
    }
    else if (obj.id == "datchem00060_5"){       
        datchem00060_4.Call();               
    }
    else if (obj.id == "datchem00060_4"){   
        ChoseList_box(lstEvaGrp,txtGroupEval.text);      
        datchem00060_1.Call();        
    }      
    else if  (obj.id == 'datchem00060_1'){    
         ChoseList_box(lstFactor,txtGroupFactor.text);
         lstFactor.value = 'ALL';              
         OnSearch();
    }       
    else if (obj.id == 'datchem00060'){      
        SetGridFormat();
        merge();
        if (idGrid.rows > 2){
            if (idGrid.GetGridData(2,13) == 'C'){
                ibtnAddNewAll.SetEnable(false);
                ibtnAddNew.SetEnable(false);
                ibtnDelete.SetEnable(false);
                ibtnSave.SetEnable(false);
                lblStatus.text = "This data was confirmed. You can not change anything more.";
            }
            else{
                ibtnAddNewAll.SetEnable(true);
                ibtnAddNew.SetEnable(true);
                ibtnDelete.SetEnable(true);
                ibtnSave.SetEnable(true);
                lblStatus.text = "";
            }
            txtComment.SetDataText(idGrid.GetGridData(2,12));
        }
        
        dat_chem00060_2.Call("SELECT");
     } 
     else if(obj.id == "dat_chem00060_2"){
         if (idGrid.rows < 3){
            if (lstFactor.value == "ALL"){
                OnNewAll();
            }
            else{
                OnNew();
            }
        }
     }    
}
function OnNew()
{    
    if (lstFactor.value=="ALL"){
        alert("Please choose one element!"); 
    }
    else{   
        idGrid.AddRow(); 
        idGrid.GetGridControl().TopRow =  idGrid.rows-1;             
        for(var i=1;i<idGrdFactor.rows;i++){
           if(idGrdFactor.GetGridData(i,0) == lstFactor.value){
                var l_element_type, l_element_nm,l_factor_nm, l_pk_factor;        
                l_element_type = idGrdFactor.GetGridData(i,2);         
                l_element_nm   = idGrdFactor.GetGridData(i,3);        
                l_pk_factor    = idGrdFactor.GetGridData(i,0); 
                idGrid.SetGridText(idGrid.rows-1,0,l_element_type);
                idGrid.SetGridText(idGrid.rows-1,1,l_element_nm);        
                idGrid.SetGridText(idGrid.rows-1,2,idGrdFactor.GetGridData(i,5));//element weight
                idGrid.SetGridText(idGrid.rows-1,4,0);//mbo weight         
                idGrid.SetGridText(idGrid.rows-1,10,l_pk_factor);
                idGrid.SetGridText(idGrid.rows-1,11,txt_thr_eva_emp_pk.GetData());          
           }
        }
    }     
}
function OnNewAll()
{    
    for (var i=1;i<idGrdFactor.rows;i++){
        idGrid.AddRow();
        idGrid.SetGridText(idGrid.rows-1,0,idGrdFactor.GetGridData(i,2));//type
        idGrid.SetGridText(idGrid.rows-1,1,idGrdFactor.GetGridData(i,3));//element 
        if(idGrdFactor.GetGridData(i,2) == "C"){       
            idGrid.SetGridText(idGrid.rows-1,3,idGrdFactor.GetGridData(i,4));//element content        
        }
        idGrid.SetGridText(idGrid.rows-1,2,idGrdFactor.GetGridData(i,5));//element weight
        idGrid.SetGridText(idGrid.rows-1,4,idGrdFactor.GetGridData(i,5));//mbo weight        
        idGrid.SetGridText(idGrid.rows-1,10,idGrdFactor.GetGridData(i,0));//element pk
        idGrid.SetGridText(idGrid.rows-1,11,txt_thr_eva_emp_pk.GetData());//thr_eva_emp_pk   
    }
}

function OnSave()
{    
 
    if (checkdata())
    {  
        ibtnAddNew.SetEnable(1);
        ibtnDelete.SetEnable(1);
        ibtnSave.SetEnable(0);  
        for (i=2;i<idGrid.rows;i++){
            idGrid.SetGridText(i,12,txtComment.GetData());
        } 
        datchem00060.Call();
    }    
}
function merge()
{
    var ctr = idGrid.GetGridControl();
    ctr.MergeCells = 4;
	ctr.MergeCol ( 0 ) = true;
    ctr.MergeCol ( 1 ) = true;
    ctr.MergeCol ( 2 ) = true;
    ctr.MergeCol ( 3 ) = false;
    ctr.MergeCol ( 4 ) = false;
    ctr.MergeCol ( 5 ) = false;
}
function OnSearch()
{    
    datchem00060.Call("SELECT");
}
function onCellClickToGrid()
{   
        if(event.row < 2) return;
        
        if((idGrid.GetGridData(event.row,0) == "C") && (event.col != 3) && (event.col != 5)){ 
            idGrid.row = -1;
            return;
        }
        
        txtComment.SetDataText(idGrid.GetGridData(2,12));  
                     
        if (idGrid.GetGridData(idGrid.row,13)=='C')
        {  
            ibtnDelete.SetEnable(0);
            ibtnSave.SetEnable(0);
            idGrid.row = -1;
            return;
        }
        else
        {
            ibtnDelete.SetEnable(1);
            ibtnSave.SetEnable(1);
            return;
        }
}

function onOpenPopup()
{
    var write_yn="";
    if(idGrid.GetGridData(event.row,13) == "C" || idGrid.GetGridData(event.row,0) == "C"){
        write_yn = "N";
    }
    else{
        write_yn = "Y";
    }
    
    if (event.col == 3)
    {
        var p_type = "MBO";
        var path = System.RootURL + '/form/ch/em/chem00060_1.aspx?p_type='+p_type+"&write_yn="+write_yn;
        var object = System.OpenModal(path ,700 , 500 , 'resizable:yes;status:yes',window);
        if(object!=null)
        {
			idGrid.SetGridText(idGrid.row,3,object[0]);
		}	
    }
    else if(event.col == 5){
        var p_type = "DESC";
        var path = System.RootURL + '/form/ch/em/chem00060_1.aspx?p_type='+p_type+"&write_yn="+write_yn;
        var object = System.OpenModal(path ,700 , 500 , 'resizable:yes;status:yes',window);
        if(object!=null)
        {
			idGrid.SetGridText(idGrid.row,5,object[0]);
		}	
    }     
}
function GetMBO(){
    return idGrid.GetGridData(idGrid.row,3);
}
function GetDESC(){
    return idGrid.GetGridData(idGrid.row,5);
}
function GetComment(){
    return txtComment.GetData();
}
function OnGridCellClick(){           
        p_type      ="COMMENT";       
        var path = System.RootURL + '/form/ch/em/chem00060_1.aspx?p_type='+p_type;
        var object = System.OpenModal(path ,580 , 500 , 'resizable:yes;status:yes',window);
        if(object!=null)
        {
			txtComment.SetDataText(object[0]);
		}	
}
function FindPos( obj , posinfo )
{
	var pobj ;	
	var x = 0  , y = 0 ;	
	
	pobj = obj;
	
	while ( pobj )
	{
		x += pobj.offsetLeft;
		y += pobj.offsetTop;
		
		// alert( pobj.offsetLeft + "="+pobj.outerHTML );
		
		if ( pobj != obj && pobj.offsetParent && pobj.tagName != "TABLE")
		{
			// alert( pobj.clientLeft + ":" + pobj.clientTop + "/" + pobj.offsetLeft + "="+pobj.outerHTML);
			x += pobj.clientLeft;
			y += pobj.clientTop;
			
		}
		pobj = pobj.offsetParent;	
	}

	
	posinfo.x = x;
	posinfo.y = y;
	posinfo.width = obj.offsetWidth;
	posinfo.height = obj.offsetHeight;
}

function OnDelete()
{
    idGrid.DeleteRow();
}

</script>
<body bgcolor='#F5F8FF'>
<gw:data id="dat_get_emp_info_chem00060" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_emp_info_chem00060" > 
                <input>
                    <input bind="txtEmp_PK" />
                </input> 
                <output>                    
                    <output bind="txtName"/>
                    <output bind="txtDept" />          
                    <output bind="txtGroup" />
                    <output bind="txtPhoto_PK" />
                    <output bind="txtPos" /> 
                    <output bind="txtPos_Time" />                                                                                                        
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00050_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_chem00050_1" > 
                <input>
                    <input bind="lstYear" /> 
                    <input bind="txtCompany_PK" /> 
                </input> 
                <output>
                    <output bind="txtEvalPeriod" />
                    <output bind="txtSchedule" />
                    <output bind="txtGradeEvatype" />
                    <output bind="txtGradeEvatimes" />
                    <output bind="txtEmpTotal" />                    
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datchem00060_4" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_chem00060_4" > 
                <input>
                    <input bind="txtEmp_PK" /> 
                    <input bind="lstYear" />
                </input> 
                <output>
                    <output bind="txtGroupEval" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00060_5" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_chem00060_5" > 
                <input>
                    <input bind="txtEmp_PK" /> 
                    <input bind="lstYear" />
                </input> 
                <output>
                    <output bind="txt_thr_eva_emp_pk" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00060_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_chem00060_1" > 
                <input>
                    <input bind="lstEvaGrp" /> 
                </input> 
                <output>
                    <output bind="txtGroupFactor" />                                     
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dat_chem00060_2" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="hr.sp_sel_chem00060_2" >
                <input bind="idGrdFactor">
                    <input bind="lstEvaGrp" />  
                    <input bind="txtLang"/>                     
                </input>
                <output bind="idGrdFactor"/>
            </dso>
        </xml>
    </gw:data>

<gw:data id="datchem00060" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="3,4,5,6,7,8,9,10,11,12,13,15" function="hr.sp_sel_chem00060" procedure="hr.sp_upd_chem00060" > 
                <input bind="idGrid">
                    <input bind="lstYear"/>  
                    <input bind="txtEmp_PK" />  
                    <input bind="txtLang" /> 
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data>       

<table id="main" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:100%; margin-left:0; margin-top:0">
	<tr>
    	<td style="width:58%;height:25%">
    <fieldset style="padding: 5;height:100%"><legend>Employee infomation</legend>
        <table border=0 cellpadding=0 cellspacing=0 style="width:100%">
            <tr>
                <td align="right" width="20%">
                    <gw:image id="imgEmp" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:130;height:130;border-top: 1 solid #87b0c6; border-bottom: 1 solid #87b0c6; border-left: 1 solid #87b0c6; border-right: 1 solid #87b0c6 "/>
                </td>
                <td width="5%">&nbsp;</td>
                <td valign="top" width="75%">
                    <table width="100%">
                        <tr>
                        	<td width="30%" height="10%">&nbsp;</td>
                            <td width="65%"></td>
                            <td width="5%"></td>
                        </tr>
                        <tr>
                        	<td nowrap align="right">Evaluation #&nbsp;</td>
                            <td nowrap><gw:list id="lstYear"   onchange="datchem00050_1.Call()"/></td>
                            <td></td>
                        </tr>
                        <tr>
                        	<td align="right">Evaluation Period&nbsp;</td>
                            <td><gw:label id="txtEvalPeriod"  text="01-Oct-2008 ~ 31-Mar-2009" 	maxlen = "20" styles='border-width:1;width:100%;'/></td>
                            <td></td>
                        </tr>
                        <tr>
                        	<td align="right">Schedule &nbsp;</td>
                            <td><gw:label id="txtSchedule"  text="01-Apr-2008 ~ 15-Apr-2009" 	maxlen = "20" styles='border-width:1;width:100%;'/></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2"><gw:label id="txtName"  text=""  styles='border-width:1;width:100%;'/></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                        	<td colspan="2"><gw:label id="txtDept"  text="" 	styles='border-width:1;width:100%;'/></td>                            
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                        	<td><gw:label id="txtPos"  text="" styles='border-width:1;width:100%;'/></td>
                            <td><gw:label id="txtPos_Time"  text="" styles='border-width:1;width:100%;'/></td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
 	         </tr>           
        </table>
     </fieldset>
    </td>
    	<td style="width:2%">&nbsp;</td>
  	 	<td style="width:40%;height:25%">
    	    <fieldset style="padding: 5;height:85%"><legend>Evaluation Group Infomation</legend>
            <table border=0 cellpadding=3 cellspacing=0 style="width:100%;height:100%">
                <tr style="height:10%">
                	<td width="30%"></td>
                    <td width="70%"></td>
                </tr>
                <tr style="height:10%">
                	<td align="right">Evaluation Group &nbsp;</td>
                    <td><gw:list id="lstEvaGrp"  onchange="datchem00060_1.Call()"/></td>
                </tr>
                <tr style="height:10%">
                	<td align="right">Element</td>
                    <td><gw:list id="lstFactor"  style="" /></td>
                </tr>
                <tr style="height:10%">
                	<td></td>
                    <td>
                    	<table width="100%">
							<tr>
                            	<td><gw:icon id="ibtnAddNewAll" alt="New All"  text="New All"  img="in"  styles="width:100%;display:none" onclick="OnNewAll()"/></td>
                            	<td><gw:icon id="ibtnAddNew" alt="New"  text="New"  img="in"  styles="width:100%" onclick="OnNew()"/></td>
                                <td><gw:icon id="ibtnSave" alt="Save"  text="Save"  img="in"  styles="width:100%" onclick="OnSave()"/></td>
                                <td><gw:icon id="ibtnDelete" alt="Delete"  text="Delete"  img="in"  styles="width:100%" onclick="OnDelete()"/></td>
                            </tr>
                        </table>
                    </td>
		         </tr>
		         <tr style="height:60%">
                	<td align="right" colspan=2><gw:label id="lblStatus" /></td>                    
                </tr>
        	</table>
            </fieldset>
    	</td>
    </tr>  
    <tr>
        <td colspan=3 style="height:1%">&nbsp;</td>
    </tr> 
  
    <tr>
        <td style="width:100%;height:43%" colspan=3>
             <gw:grid   
            id="idGrid" 
            header="Type|Element|E.Weight|MBO Plan|Weight|Description|Unit|Current|Target|_eva_master_pk|_Factor_PK|_thr_eva_emp_pk|_Comment|_Status|_Lang|_mbo_pk"                                       
            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
            aligns="0|0|1|0|0|0|3|0|0|0|0|0|0|0|0|0"    
            defaults="|||||||||||||||"                     
            editcol="0|0|0|1|1|1|1|1|1|1|0|0|0|0|0|0"  
            widths="0|0|1500|2000|1000|4000|1500|2000|1000|1000|1000|1000|1000|1000|1000|1000"
            styles="width:100%; height:100%" oncellclick="onCellClickToGrid()" onafteredit="checkNumberInvalid()" oncelldblclick="onOpenPopup()"   
            acceptNullDate="T" editcolcolor="true" 
            sorting="T"/>  
        </td>    
    </tr>    
    <tr>
        <td colspan=3 style="width:60%;height:20%">
            <table border=0  cellpadding=0 cellspacing=0 style="width:100%">                
                <tr>
                    <!--<td nowrap align=center style="width:30%;border-right: solid 1 Black;border-bottom: solid 1 Black">Stage</td>-->
                    <td nowrap colspan=2 align=center style="width:100%">
                    <a href="#tips" onClick="OnGridCellClick()"
                                    style="text-decoration: none; color=#0000ff"><b>Comments&nbsp;</b></a></td>                    
                </tr>
                <tr>
                    <!--<td nowrap style="width:30%;border-right: solid 1 Black" valign=top>&nbsp;Self-Evaluation</td>-->
                    <td colpans=2 style="width:100%;">
                        <gw:textarea id="txtComment" rows=5 text="" onchange="" styles='width:100%;'/>
                    </td>                   
                </tr>
            </table>
        </td>
    </tr>      
</table>
<gw:grid   
    id="idGrdFactor" 
    header="PK|Seq|Element Type|Element|Contents|Weight"                                       
    format="0|0|0|0|0|0"  
    aligns="0|0|0|0|0|0"    
    defaults="|||||"                     
    editcol="0|0|0|0|0|0"  
    widths="0|0|2000|2000|2000|0"   
    acceptNullDate="T" 
    styles="display:none" 
    sorting="T"/>    
<gw:textbox id="txtEmp_PK" style="display:none" />
<gw:textbox id="txtPhoto_PK" style="display:none" />
<gw:textbox id="txtGradeEvatype" style="display:none" />
<gw:textbox id="txtGradeEvatimes" style="display:none" />
<gw:textbox id="txtEmpTotal" style="display:none" />
<gw:textbox id="txtGroupEval" style="display:none" />
<gw:textbox id="txtGroupFactor" style="display:none" />
<gw:textbox id="txt_thr_eva_emp_pk" style="display:none" />
<gw:textbox id="txtCompany_PK" style="display:none" />
<gw:textbox id="txtLang" style="display:none" />
<gw:textbox id="txtGroup" style="display:none" />
<gw:textbox id="txtFactor" style="display:none" />


</body>



