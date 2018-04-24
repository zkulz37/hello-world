<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

//_THR_EVA_MASTER_PK|_THR_EVA_GRADE_V2_PK|SEQ|FROM SCORE|TO SCORE|GRADE|GRADE TYPE|DESCRIPTION
var p_eva_master_pk=0;
var p_eva_grade_v2=1;
var p_eva_group=2;
var p_seq=3;
var p_from_score=4;
var p_to_score=5;
var p_grade=6;
var p_grade_type=7;
var p_description=8;
var p_eva_group_pk=9;

var check_alert="";
var check_delete_flag=false;

var check_init=0;
var l_eva_lst=1;

//for form is popup
var is_popup;
var l_eva_master_pk,l_eva_group_pk,l_grade_kind;
var f_lag_check=0;

function BodyInit()
{
   
   is_popup="<%=Request("p_pop_up") %>";
   if(is_popup!="")//su dung form nhu popup
   {
        l_eva_master_pk="<%=Request("p_eva_master_pk") %>";
        l_eva_group_pk="<%=Request("p_eva_group") %>";
        l_grade_kind="<%=Request("p_grade_kind") %>";
   }


   var lstEvaYear_Data = "<%=ESysLib.SetListDataSQL("SELECT PK, E.EVA_YYYY || ' - ' || E.EVA_SEQ FROM THR_EVA_MASTER E WHERE E.DEL_IF = 0 ORDER BY E.EVA_YYYY || ' - ' || E.EVA_SEQ DESC")%>"; 
   lstEvaYear.SetDataText(lstEvaYear_Data); 
   lstEvaYear_copy.SetDataText(lstEvaYear_Data+"|0|Select ..."); 
   lstEvaYear_copy.value="0";
   var tmp="#1;KIND 1|#2;KIND 2";
    grdGradeEntry.SetComboFormat(p_grade_type,tmp);

     if(is_popup!="")//su dung form nhu popup
        lstEvaYear.value=l_eva_master_pk;
    
      
   onBindData();
}

function onBindData()
{
    dso_chem00040_4.Call();
    
}

function onChangeEva(n)
{
    l_eva_lst=n;
    if(n==1)
        txtMasterPK.text=lstEvaYear.value;
    else
        txtMasterPK.text=lstEvaYear_copy.value;
    datchem00040_v2_lst.Call();
}
   
function OnSelectEvaYear()
{
	dso_chem00040_1.Call();
	
}
function OnDataReceive(obj)
{
    
    if(obj.id=="dso_chem00040_4")
    {
        l_eva_lst=1;
        txtMasterPK.text=lstEvaYear.value;
        datchem00040_v2_lst.Call();
    }
    else if(obj.id=="datchem00040_v2_lst")
    {
        //alert(l_eva_group_pk);
        //alert(txtEvaGroup.text);
		//alert(l_eva_lst);
        if(l_eva_lst==1)
            lstEvaluationGrp.SetDataText(txtEvaGroup.text);
        else
            lstEvaluationGrp_Copy.SetDataText(txtEvaGroup.text);
        
        if(is_popup!="" && f_lag_check==0)//su dung form nhu popup
        {
            f_lag_check=1;//ko check nua
            lstEvaYear.value=l_eva_master_pk;
            lstEvaluationGrp.value=l_eva_group_pk;
            lstGradeKind.value=l_grade_kind;

            lstEvaYear.SetEnable(0);
            lstEvaluationGrp.SetEnable(0);
            lstGradeKind.SetEnable(0);
            btnCopy.SetEnable(0);

            btnNew.SetEnable(0);
		    btnSave.SetEnable(0);
		    btnDelete.SetEnable(0);
            lstEvaYear_copy.SetEnable(0);
            lstEvaluationGrp_Copy.SetEnable(0);
            dso_chem00040_2.Call("SELECT");
        }

        check_init=1;
    }
    else if(obj.id == "dso_chem00040_1")
	{
		action();
		OnSearch();
	}
	else if(obj.id == "dso_chem00040_1")
	{	
		if(check_delete_flag==true)
		{
			check_delete_flag=false;  // nha co delete
		}
	}
	else if(obj.id == "dso_chem00040_3")
	{
		if(txtResult.text=='1')
		{
			alert("Copy Grade sucessful.");
			return;		
		}
		else if(txtResult.text=='0')
		{
			alert("Evaluation period close.");
			return;
		}
		else if(txtResult.text=='2')
		{	
			alert("Not have data to copy.");
			return;
		}
		else if(txtResult.text=='3')
		{	
			alert("Data Exist.Delete data before copy!");
			return;
		}
		else
		{
			alert("Copy error");
			return;
		}
	}
}
function action()
{
	if(is_popup=="")
    {
        if(txtClose_YN.text=="Y")  // evaluation period close
	    {
		    btnNew.SetEnable(false);
		    btnSave.SetEnable(false);
		    btnDelete.SetEnable(false);
		    //btnCopy.SetEnable(false);

		    lblClose_YN.text="Close";
	    }
	    else
	    {
		    btnNew.SetEnable(true);
		    btnSave.SetEnable(true);
		    btnDelete.SetEnable(true);
		    btnCopy.SetEnable(true);
		    lblClose_YN.text="Open";
	    }
    }
}
function OnSearch()
{
    if(check_init==1)//da khoi tao xong
	    dso_chem00040_2.Call("SELECT");
}
function OnAddnew()
{	
	if(lstEvaYear.GetData() == "")
	{
		alert("Unknown Evaluation number, select one in list before add new data");
		return;
	}		
	grdGradeEntry.AddRow();
	var tmp_seq		
	if(grdGradeEntry.rows<=2)
	{
		tmp_seq=1;
	}	
	else
	{
		tmp_seq=Number(grdGradeEntry.GetGridData(grdGradeEntry.rows -2,p_seq))+1;
	}			
	grdGradeEntry.SetGridText(grdGradeEntry.rows -1,p_eva_master_pk,lstEvaYear.value);
	grdGradeEntry.SetGridText(grdGradeEntry.rows -1,p_seq,tmp_seq);
	grdGradeEntry.SetGridText(grdGradeEntry.rows -1,p_eva_group_pk,lstEvaluationGrp.value);
    if(lstGradeKind.value!="ALL")
        grdGradeEntry.SetGridText(grdGradeEntry.rows -1,p_grade_type,lstGradeKind.value);
	
}
function OnSave()
{
    if(check_init==1)//da khoi tao xong
    {
	    if(check_delete_flag==true) // thao tac delete
	    {
		    dso_chem00040_2.Call();
	    }
	    else	  // chi update
	    {		
		    if(check_save())
		    {
			    dso_chem00040_2.Call();
		    }
		    else
		    {
			    alert(check_alert);
			    return;
		    }
	    }
    }
}
function check_save()
{	
	for (var i=1;i<grdGradeEntry.rows;i++) // check on the same row
	{				
		if (grdGradeEntry.GetGridData(i,p_grade)=="" || (grdGradeEntry.GetGridData(i,p_from_score)=="" && grdGradeEntry.GetGridData(i,p_to_score)=="" ))
		{
			check_alert="Please input data at row " + i ;
			return 0;
		}	
		/*if(grdGradeEntry.GetGridData(i,p_from_score)>grdGradeEntry.GetGridData(i,p_to_score)&& grdGradeEntry.GetGridData(i,p_from_score)!="" && grdGradeEntry.GetGridData(i,p_to_score)!="")
		{
			check_alert="Please check data at row " + i + "(from score > to score)";
			return 0;
		}*/
			
	}	
    /* tam thoi bo qua vi dang con loi
	for (var i=1;i<grdGradeEntry.rows-1;i++)  // check on the whole data
	{			
		for (var j=i+1;j<grdGradeEntry.rows;j++)
		{	
			if(grdGradeEntry.GetGridData(i,p_to_score)>=grdGradeEntry.GetGridData(j,p_from_score) && grdGradeEntry.GetGridData(i,p_grade_type)==grdGradeEntry.GetGridData(j,p_grade_type) )  // so sanh to score cua dong truoc voi from score cua dong sau
			{				
				check_alert="Please check data at row " + j + "(from score < to score row pre)";
				return 0;				
			}
			if(grdGradeEntry.GetGridData(i,p_from_score)==grdGradeEntry.GetGridData(j,p_from_score) && grdGradeEntry.GetGridData(i,p_grade_type)==grdGradeEntry.GetGridData(j,p_grade_type))
			{				
				check_alert="Please check data at row " + j + "(dulicate from score)";
				return 0;				
			}
			if(grdGradeEntry.GetGridData(i,p_to_score)==grdGradeEntry.GetGridData(j,p_to_score) && grdGradeEntry.GetGridData(i,p_grade_type)==grdGradeEntry.GetGridData(j,p_grade_type))
			{				
				check_alert="Please check data at row " + j + "(dulicate to score)";
				return 0;				
			}
			if(grdGradeEntry.GetGridData(i,p_from_score)==grdGradeEntry.GetGridData(j,p_from_score) && grdGradeEntry.GetGridData(i,p_to_score)==grdGradeEntry.GetGridData(j,p_to_score) && grdGradeEntry.GetGridData(i,p_grade)==grdGradeEntry.GetGridData(j,p_grade)&& grdGradeEntry.GetGridData(i,p_grade_type)==grdGradeEntry.GetGridData(j,p_grade_type))
			{				
				check_alert="Please check data at row " + j + "(dulicate row)";
				return 0;				
			}
			if(grdGradeEntry.GetGridData(i,p_grade)==grdGradeEntry.GetGridData(j,p_grade)&& grdGradeEntry.GetGridData(i,p_grade_type)==grdGradeEntry.GetGridData(j,p_grade_type))
			{				
				check_alert="Please check data at row " + j + "(dulicate grade for the same kind.)";
				return 0;				
			}
			
		}	
	}*/
	return 1;
}
function OnDelete()
{
    if(check_init==1)//da khoi tao xong
    {
	    check_delete_flag=true;
	    var mapctrl = grdGradeEntry.GetGridControl();
	    if(grdGradeEntry.rows <= 1)
	    {
		    alert("No data to delete");
		    return; 
	    }
	    if (confirm("do you want to delte?"))
	    {
		    for(i=1; i<grdGradeEntry.rows;i++)
		    {
			    if (mapctrl.IsSelected(i)) 
			    {
				    grdGradeEntry.DeleteRowAt(i)
			    }
		    }
	    }        
    }
}

function OnCopyData()
{
	
	if(check_init==1)//da khoi tao xong
    {
        if(lstEvaYear_copy.value=="0" || lstEvaluationGrp_Copy.value=="")
            alert("Please select Eva period and Group to copy");
        else if (confirm("do you want to copy?"))
		    {
			    dso_chem00040_3.Call();
		    }
    }
	
}
function On_AfterEdit()
{
	cIdx=event.col;
	var tmpValue=grdGradeEntry.GetGridData(event.row,cIdx);		
	if(cIdx==p_from_score||cIdx==p_to_score||cIdx==p_seq)
	{
		if(cIdx==p_from_score)
		{
			tmpcol="FROM SCORE";
		}
		else if(cIdx==p_to_score)
		{
			tmpcol="TO SCORE";
		}
		else
		{
			tmpcol="SEQ";
		}		
		if(isNaN(tmpValue))	
		{
			alert("Input number for column "+ tmpcol);
			return;
		}
	}

}

</script>

<body>
<!---------------------dung chung list-------------------------------------------------->
<gw:data id="datchem00040_v2_lst" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00000_v2_grp" > 
                <input>
                    <input bind="txtMasterPK"/> 
                </input> 
                <output>
                    <output bind="txtEvaGroup" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dso_chem00040_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_CHEM00040_1_V2" > 
                <input>
                    <input bind="lstEvaYear" /> 
                </input> 
                <output>					                   
					<output bind="txtClose_YN" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------------------------------------------->
<gw:data id="dso_chem00040_2" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="HR_SEL_CHEM00040_2_V2" procedure="HR_UPD_CHEM00040_2_V2" >
                <input bind="grdGradeEntry">
                    <input bind="lstEvaYear" />
                    <input bind="lstEvaluationGrp" />
					<input bind="lstGradeKind" />
                </input>
                <output bind="grdGradeEntry"/>
            </dso>
        </xml>
</gw:data>
<!----------------------------------------------------------------------->
<gw:data id="dso_chem00040_3"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="process" parameter="0,1"  procedure="hr_pro_chem00040_3_v2"> 
            <input> 
                <input bind="lstEvaYear" />
                <input bind="lstEvaluationGrp" />
                <input bind="lstEvaYear_copy" />
                <input bind="lstEvaluationGrp_Copy" />
            </input>
            <output>
                <output bind="txtResult" />
            </output>
        </dso> 
    </xml> 
</gw:data> 


<gw:data id="dso_chem00040_4"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="process" parameter="0,1"  procedure="hr_pro_chem00040_4_v2"> 
            <input> 
                <input bind="lstEvaYear" />
            </input>
            <output>
                <output bind="lblMbo_1" />
                <output bind="lblMbo_2" />
                <output bind="lblCapa_1" />
                <output bind="lblCapa_2" />
                <output bind="lblLanguage_1" />
                <output bind="lblLanguage_2" />
                <output bind="txtHR_Score" />
            </output>
        </dso> 
    </xml> 
</gw:data> 
<!------------------------------------------------------------------------>
    <table id="main" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:100%; margin-left:0; margin-top:0">
                    <tr style="height: 1%">
						<td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td>
                        <td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td>
                        <td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td>
                        <td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td>
                        <td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td>
                        <td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td>
                        <td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td>
                        <td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td>
                        <td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td>
                        <td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td><td width = "1%" align="right">&nbsp;</td>
					</tr>
					<tr style="height: 5%">
						<td colspan=10 align="right">Eva Period</td>
						<td colspan=10 align="left"><gw:list  id="lstEvaYear" value='ALL' maxlen = "100" onchange="onChangeEva(1)" ></gw:list></td>
                        <td colspan=10 align=right>Eva Group</td>
                        <td colspan=15>
                            <gw:list id="lstEvaluationGrp" styles='width:100%' onchange="OnSearch()" />
                        </td>
						<td colspan=10 align="right">Grade Kind</td>
						<td colspan=10 align="left"><gw:list  id="lstGradeKind" value="ALL" onchange="OnSearch()">
									<data>|1|Kind 1|2|Kind 2|ALL|Select All</data>
					              </gw:list></td>
						<td colspan=5 align="right"><gw:icon id="btnSearch" alt="Search" img="in" text="Search" onclick="OnSearch()" /></td>
						<td colspan=5 align="right"><gw:icon id="btnNew" alt="New entry" img="in" text="New" onclick="OnAddnew()" /></td>
						<td colspan=5 align="right"><gw:icon id="btnSave" alt="Save" img="in" text="Save" onclick="OnSave()" /></td>
						<td colspan=5 align="right"><gw:icon id="btnDelete" alt="Delete" img="in" text="Delete" onclick="OnDelete()" /></td>
                        <td colspan=2 align="right">&nbsp;</td>
						<td colspan=10 align="right"><gw:label id="lblStatus" onenterkey   ="" text="Status:" styles='width:100%;color:red'/></td>
						<td colspan=10 align="left"><gw:label id="lblClose_YN" onenterkey   ="" text="Open" styles='width:100%;color:red'/></td>
					</tr>
                    <tr style="height: 5%">
						
						<td colspan=10 align="right" styles='width:100%' >Copy to</td>
						<td colspan=10 align="left" styles='width:100%'><gw:list  id="lstEvaYear_copy" value='' maxlen = "100" onchange="onChangeEva(2)" ></gw:list></td>
                        <td colspan=10 align=right>Eva Group</td>
                        <td colspan=15>
                            <gw:list id="lstEvaluationGrp_Copy" styles='width:100%' onchange="" />
                        </td>
						<td colspan=5 align="center"><gw:icon id="btnCopy" img="in" text="Copy" onclick="OnCopyData()" /></td>
                        <td colspan=50 align="left">&nbsp;</td>
						
					</tr>
					<tr style="height: 60%">
						<td  colspan=100 style="width:100%"> 
                            <gw:grid   
	                            id="grdGradeEntry"  
	                            header="_THR_EVA_MASTER_PK|_THR_EVA_GRADE_V2_PK|EVA GROUP|SEQ|FROM SCORE|TO SCORE|GRADE|GRADE KIND|DESCRIPTION|_eva_group_pk"   
	                            format="0|0|0|-0|-0|-0|0|2|0|0"  
	                            aligns="0|0|0|0|0|0|0|0|0|0"  
	                            defaults="||||||||||" 
	                            editcol="0|0|0|1|1|1|1|1|1|1|0" 
	                            widths="0|0|2000|500|1200|1200|1200|1200|2000|4000|0" 
	                            styles="width:100%; height:100%"   
	                            sorting="T" 
								onafteredit="On_AfterEdit()"
	                             /> 
                        </td>
					</tr>
					<tr style="height:29%;border:1" >
						<td colspan=100 width="12%">
                            <fieldset style="padding: 5;height:100%"><legend>Formula infomation</legend>
							        <table width="100%">
								        <tr>
									        <td width = "20%" align="right"><gw:label id="lable1" text="Kind 1" styles='width:100%;color:blue;font-size:13'/></td>						
									        <td width = "2%" align="left" >&nbsp;</td>
									        <td width = "20%" align="right" ><gw:label id="lable2" text="Kind 2" styles='width:100%;color:blue;font-size:13'/></td>
									        <td width = "58%" align="left" >&nbsp;</td>
														
								        </tr>
                                         <tr>
									        <td width = "20%" align="right"><gw:label id="lblMbo_1" text="Capacity: 30%" styles='width:100%;color:black'/></td>						
									        <td width = "2%" align="left">&nbsp;</td>
									        <td width = "20%" align="right"><gw:label id="lblMbo_2" text="Capacity: 30%" styles='width:100%;color:black'/></td>
									        <td width = "58%" align="left">&nbsp;</td>
														
								        </tr>
								        <tr>
									        <td width = "20%" align="right"><gw:label id="lblCapa_1" text="Capacity: 30%" styles='width:100%;color:black'/></td>						
									        <td width = "2%" align="left">&nbsp;</td>
									        <td width = "20%" align="right"><gw:label id="lblCapa_2" text="Capacity: 30%" styles='width:100%;color:black'/></td>
									        <td width = "58%" align="left">&nbsp;</td>
														
								        </tr>
								        <tr id="tr_LangEva">
									        <td width = "20%" align="right"><gw:label id="lblLanguage_1" text="Language:10%" styles='width:100%;color:black'/></td>						
									        <td width = "2%" align="left">&nbsp;</td>
									        <td width = "20%" align="right"><gw:label id="lblLanguage_2" text="Language:10%" styles='width:100%;color:black'/></td>
									        <td width = "58%" align="left">&nbsp;</td>
														
								        </tr>
							        </table>
                            </fieldset>
						</td>
					</tr>					
	</table>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtClose_YN" styles="display:none;" />
<gw:textbox id="txtResult" styles="display:none;" />
<gw:textbox id="txtEvaGroup" styles="display:none;" />
<gw:textbox id="txtHR_Score" styles="display:none;" />
</body>
</html>
