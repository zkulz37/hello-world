<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Result Inquiry</title>
    <%   ESysLib.SetUser(Session("APP_DBUSER"))%>
</head>

<script>

var pk= 0,
p_close= 1,
p_org= 2,
p_id =3,
p_full=4,
p_Ability= 5,
p_Ability_Result= 6,
p_behaviour_w= 7,
p_behaviour_p= 8,
p_behaviour_Safe= 9,
p_behaviour_total= 10,
p_QSS_point= 11,
p_QSS_remark= 12,
p_Reward= 13,
p_Reward_remark= 14,
p_Total = 15;
var binit=true;

function BodyInit()
{
    var data="";

    data = "<%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and  TCO_COMPANY_PK='" + session("company_pk")+ "'  connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id " )%>|ALL|Select all";    
    lstOrganiZation.SetDataText(data);
    lstOrganiZation.value="ALL";
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.GROUP_ID || '-' || a.group_nm FROM thr_eva_group a WHERE a.del_if = 0")%>";
    lstEvaluationGrp.SetDataText(ls_data+ "|%|Select ALL");
    lstEvaluationGrp.SetDataText("%");
    data = "<%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where del_if=0 order by 2 desc")%>";    
    lstEvaMaster.SetDataText(data);    
    
    //OnChangeMaster();
    grdEva.GetGridControl().FrozenCols = 1;
	SetGridHeader2();
}
function OnSearch()
{
    dso_Inquiry.Call("SELECT");
    TotalItem();
}
function OnPrint()
{
    
        var  url= System.RootURL + "/reports/ch/em/rpt_eva_management.aspx?p_eva_master_pk="+lstEvaMaster.value +"&p_org_pk="+lstOrganiZation.value+"&p_lst="+lstTemp2.value+"&p_temp="+txtEmployee.text+"&p_wg="+lstWG.value;
        System.OpenTargetPage( url, "_blank" );
         //var url = System.RootURL + "/system/ReportEngine.aspx?file=ch/em/EvalResultInquiry.rpt&procedure=HR.SP_SEL_CHEM00120_1|HR.SP_SEL_CHEM00120_2|HR.SP_SEL_CHEM00120_3"
        //+ "&parameter="+grdEva.GetGridData(grdEva.row,37)+"|"+grdEva.GetGridData(grdEva.row,37)+"|"+grdEva.GetGridData(grdEva.row,37);
        //window.open(url);
}

function SetGridHeader2()
{
   var fg=grdEva.GetGridControl();  
    /*grdEva.SetCellBold(1,0,1,43,true);
    fg.Cell(12, 0, 0, 2, fg.Cols-2) = 8;
    fg.FixedRows = 3;
    fg.FixCols=1;
    fg.MergeCells = 5;
    */
	//pk 0|_close 1|org 2|id 3| full 4|Ability 5|Ability Result 6 |behaviour working 7|behaviour policy 5|behaviour Safe 9|Total 10|QSS point 11|QSS remark 12|Reward 13|Reward remark 14|Total 15
    
	    if (binit==true)
        {
            fg.rows=fg.rows+1;
			binit=false;
        }
        fg.FixedRows = 2;
        fg.FixCols=1;
        fg.MergeCells =5;
		
		grdEva.SetCellBold(1,0,1,p_Total,true);
	
		fg.MergeCol(p_Total) =true	;
        fg.Cell(0, 0, p_Total, 1, p_Total)  = "TOTAL";   //fg.Cell(0,row, from_col, row, to_col)		
		
        fg.MergeCol(p_id) =true	;
        fg.Cell(0, 0, p_id, 1, p_id)  = "Emp ID";   //fg.Cell(0,row, from_col, row, to_col)	
        
		fg.MergeCol(p_org) =true	;
        fg.Cell(0, 0, p_org, 1, p_org)  = "Organization";   //fg.Cell(0,row, from_col, row, to_col)	
        
		fg.MergeCol(p_full) =true	;
        fg.Cell(0, 0, p_full, 1, p_full)  = "Full Name";   //fg.Cell(0,row, from_col, row, to_col)	
		
		fg.MergeCol(p_full) =true	;
        fg.Cell(0, 0, p_full, 1, p_full)  = "Full Name";   //fg.Cell(0,row, from_col, row, to_col)	
	
		fg.MergeRow(0) =true	;
        fg.Cell(0, 0, p_Ability, 0, p_Ability_Result)  = "Ability";   //fg.Cell(0,row, from_col, row, to_col)	
		fg.MergeCol(p_Ability) =true	;
        fg.Cell(0, 1, p_Ability, 1, p_Ability)  = "Score";   //fg.Cell(0,row, from_col, row, to_col)
		fg.MergeCol(p_Ability_Result) =true	;		
		fg.Cell(0, 1, p_Ability_Result, 1, p_Ability_Result)  = "Result";    //fg.Cell(0,row, from_col, row, to_col)	
		
		
		fg.MergeRow(0) =true	;
        fg.Cell(0, 0, p_behaviour_w, 0, p_behaviour_total)  = "BEHAVIOUR";   //fg.Cell(0,row, from_col, row, to_col)	
		fg.MergeCol(p_behaviour_w) =true	;
        fg.Cell(0, 1, p_behaviour_w, 1, p_behaviour_w)  = "Working";   //fg.Cell(0,row, from_col, row, to_col)
		fg.MergeCol(p_behaviour_p) =true	;		
		fg.Cell(0, 1, p_behaviour_p, 1, p_behaviour_p)  = "Policy";    //fg.Cell(0,row, from_col, row, to_col)	
		fg.MergeCol(p_behaviour_Safe) =true	;		
		fg.Cell(0, 1, p_behaviour_Safe, 1, p_behaviour_Safe)  = "Safe";    //fg.Cell(0,row, from_col, row, to_col)	
		fg.MergeCol(p_behaviour_total) =true	;		
		fg.Cell(0, 1, p_behaviour_total, 1, p_behaviour_total)  = "TOTAL";    //fg.Cell(0,row, from_col, row, to_col)	
		
		
		fg.MergeRow(0) =true	;
        fg.Cell(0, 0, p_QSS_point, 0, p_QSS_remark)  = "QSS";   //fg.Cell(0,row, from_col, row, to_col)	
		fg.MergeCol(p_QSS_point) =true	;
        fg.Cell(0, 1, p_QSS_point, 1, p_QSS_point)  = "QSS point";   //fg.Cell(0,row, from_col, row, to_col)
		fg.MergeCol(p_QSS_remark) =true	;		
		fg.Cell(0, 1, p_QSS_remark, 1, p_QSS_remark)  = "Remark";    //fg.Cell(0,row, from_col, row, to_col)	
		
		
		fg.MergeRow(0) =true	;
        fg.Cell(0, 0, p_Reward, 0, p_Reward_remark)  = "REWARD";   //fg.Cell(0,row, from_col, row, to_col)	
		fg.MergeCol(p_Reward) =true	;
        fg.Cell(0, 1, p_Reward, 1, p_Reward)  = "Remark point";   //fg.Cell(0,row, from_col, row, to_col)
		fg.MergeCol(p_Reward_remark) =true	;		
		fg.Cell(0, 1, p_Reward_remark, 1, p_Reward_remark)  = "Remark";    //fg.Cell(0,row, from_col, row, to_col)	
		
		
		auto_resize_column(grdEva,0,grdEva.cols-1,9);    
		/*if(grdEva.rows>2 && grdEva.GetGridData(grdEva.rows-1,p_pk)=="Y")
        for(var i=2 ;i<grdEva.rows ;i++)
		{
		grdEva.SetCellBgColor(1,p_org,i ,p_Total,0xBAEDD3);
		}
		else*/
		if(grdEva.rows>2 && grdEva.GetGridData(grdEva.rows-1,1)=="Y")
		grdEva.SetCellBgColor(2,p_org,grdEva.rows -1 ,p_Total,0xFFCCFF);
}

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
function OnDataReceive(obj){
   if(obj.id == "dso_Inquiry"){
        TotalItem();
        SetGridHeader2(grdEva);
    }
}
function OnChangeMaster(){
   // dso_ReviewerList.Call("SELECT");
   OnSearch();
    
}
function TotalItem()
 {
    var iNumRecord    =  grdEva.rows-2;
    lblRecord_M.text = iNumRecord  + " Row(s)" ;     
 }

function OnSave()
{ if(confirm("Do you want to save?\nBạn có muốn lưu lại?"))
	{dso_Inquiry.Call();
	}
}

function OnShowPopup()
{     
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        { lstOrganiZation.value = obj;
			
            
        }
}

</script>

<body>
    <gw:data id="dso_Inquiry" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="HR.sp_sel_chem00190"   parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" procedure="hr.sp_upd_chem00190" >  
                    <input bind="grdEva">  
                    <input bind="lstEvaMaster" />
                    <input bind="lstOrganiZation" />
                    <input bind="lstEvaluationGrp" />  
                    
					<input bind="lstTemp2" />  
					<input bind="txtEmployee" /> 
                    
                    <input bind="lstWG" />
                </input> 
                <output bind="grdEva" /> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_ReviewerList" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="HR.sp_sel_reviewer_by_master">  
                <input>  
                    <input bind="lstEvaMaster" />
                </input> 
                <output>
                    <output bind="lstEvaluator" /> 
                </output> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%" valign="top">
                        <td>
                            <fieldset>
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td width="8%" align="right">
                                            <a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >
											Organization </a>    
                                        </td>
                                        <td width="15%">
                                            <gw:list id="lstOrganiZation" onchange="OnSearch()" />
                                        </td>
                                        <td width="10%" align=right>
                                            Eva.Term
                                        </td>
                                        <td width="10%">
                                            <gw:list id="lstEvaMaster" onchange="OnChangeMaster()" styles="width:100px" />
                                        </td>
                                        
										<td width="5%">Search by</td>
										<td width="11%">
											<gw:list  id="lstTemp2" value="1" styles='width:100%' onchange=""> 
												<data>LIST|3|Name|1|Emp ID|2|Card ID</data> 
										</gw:list>
									</td>
									    <td width="15%">
                                            <gw:textbox id="txtEmployee" onenterkey="OnSearch()" />
                                        </td>
                                        <td width="5%"></td>
                                        <td style="width: 10%" align="center">
                                            <gw:label id="lblRecord_M" style="font-weight: bold; color: red; font-size: 12" text="0 row(s)" />
                                        </td>
                                        <td with="2%">
                                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                                        </td>
                                        <td with="2%">
                                            <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                                        </td>
										<td width="2%">
                                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
                                        </td>
                                        
                                    </tr>
									
									  <tr>
                                        <td width="8%" align=right>W.Group</td>
                                        <td width="15%"><gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                                                     <data><%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0")%>|ALL|Select All</data></gw:list>
                                        </td>
                                        <td width="10%" align=right>
                                            Eva.Group</td>
                                        <td width="10%">
                                            <gw:list id="lstEvaluationGrp" styles='width:100%' onchange="OnSearch()" />
                                        </td>
                                        <td width="10%" align=right>
                                        </td>
                                        <td width="8%">
                                        
                                        </td>
                                        
                                        
                                    </tr>
									
                                </table>
                                
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 96%" valign="top">
                        <td>
                            <table style="width: 100%; height: 100%" border="1">
                                <tr style="height: 100%">
                                    <td>
                                        <gw:grid id="grdEva" 
                                            header="_pk|_close|Organization|ID|Full name|Ability|Ability Result|behaviour working|behaviour policy|behaviour Safe|Total|QSS point|QSS remark|Reward|Reward remark|Total" 
                                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                            defaults="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                            editcol="0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|0"  
                                             widths="0|0|2000|1000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
                                            sorting='T' styles="width:100%; height:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtEva_Emp_PK" styles="display:none" />
    <gw:list id="lstEvaluator" onchange="OnSearch()" styles="display:none" />
    <gw:textbox id="txtReviewer_pk1" styles="display:none"/>
    <gw:textbox id="txtReviewer_pk2" styles="display:none"/>
</body>
</html>
