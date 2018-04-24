<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>MBO checking</title>
		<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
	</head>
	<script>
        var check_init=0;
        var startTime,interval_time;
        //header="Organization|Eva Group|Emp ID|Full Name|Factor|Target 1|Target 2|Weight|Self Score|Manager 1|Score 1|Manager 2|Score 2|Final Score|MBO Status|MBO Closed Y/N|Final Status|Data Closed Y/N|_MBO_PK|_EVA_YYYY|_EVA_SEQ"
        var stt = 0;
        var idGrid_Organization         =0,
			idGrid_Eva_Period           =++stt,		
            idGrid_Eva_Group            =++stt,
            idGrid_Emp_ID  				=++stt,
            idGrid_Full_Name            =++stt,
			idGrid_Manager_1       		=++stt,
			idGrid_Manager_2       		=++stt,
			idGrid_MBO_Status       	=++stt,
            idGrid_MBO_Closed_YN   		=++stt,
            idGrid_Final_Status      	=++stt,
			idGrid_Data_Closed_YN       =++stt,
            idGrid_Action_Plan       	=++stt, 
			idGrid_Target1       		=++stt, 
			idGrid_Target2       		=++stt, 			
            idGrid_Weight   			=++stt,
            idGrid_Self_Score        	=++stt,            
            idGrid_Score_1 				=++stt,			
            idGrid_Score_2 				=++stt,
            idGrid_Final_Score          =++stt,            
            idGrid_MBO_PK 				=++stt,
            idGrid_EVA_YYYY         	=++stt,
            idGrid_EVA_SEQ       		=++stt;
        var v_language = "<%=Session("SESSION_LANG")%>";
        function BodyInit()
        {          
            if (v_language!="ENG")
                System.Translate(document);    
           // dataEva_Period.Call();
		   idGrid.GetGridControl().FrozenCols =5;	
		   idGrid.GetGridControl().ScrollTrack=true;
		   onBindData();
		   dso_Period.Call();
        }
        function BindingDataList()
        {       
        }
        function onBindData() 
		{
		    
			var ctrl = idGrid.GetGridControl();
			ctrl.MergeCells = 2;
			ctrl.MergeCol(idGrid_Organization) = true;
			ctrl.MergeCol(idGrid_Eva_Period) = true;
			ctrl.MergeCol(idGrid_Eva_Group) = true;
			ctrl.MergeCol(idGrid_Emp_ID) = true;
			ctrl.MergeCol(idGrid_Full_Name) = true;
			ctrl.MergeCol(idGrid_Manager_1) = true;
			ctrl.MergeCol(idGrid_Manager_2) = true;
			ctrl.MergeCol(idGrid_MBO_Status) = true;
			ctrl.MergeCol(idGrid_MBO_Closed_YN) = true;
			ctrl.MergeCol(idGrid_Final_Status) = true;
			ctrl.MergeCol(idGrid_Data_Closed_YN) = true;
			//alert('ok');
		}
        function auto_resize_column(obj,col1,col2,font_size)
        {
            if(font_size!=0)
                obj.GetGridControl().FontSize =font_size;   
            obj.GetGridControl().AutoSize(col1,col2,false,0);  
        }

        function OnDataReceive(obj)
        {
           if(obj.id=="dso_Period")
			{
				//alert('ok');
				dso_Eva_Group.Call();
			}
			
			if(obj.id=="dso_Eva_Group")
			{
				
				lstEvaluationGrp.SetDataText(txtEvaGrp.text+"|ALL|Select All");
				lstEvaluationGrp.value="ALL";
				dso_Eva_Level.Call();
			   
			}
			
			if(obj.id=="dso_Eva_Level")
			{

				lstMng_Level.SetDataText(txtLevel.text); 
				check_init=1;
			}
			if(obj.id=="HR_SEL_CHEM00290_V2_01")
			{
				idGrid.Subtotal( 0, 2, 3, '14!15!16!17!18');
				lblRecord.text=idGrid.rows-1+" Rec(s)";
			}
			
        }
		
		function OnChangeEvaPeriod()
		{
			dso_Period.Call();
		}
	
        function onReport()
        {    
			//alert(lstEvaMaster.GetText());
			//return;
            var url=System.RootURL + '/reports/ch/em/'+lstReport.value+'?p_1=' + lstEvaMaster.value+ '&p_2='+lstEvaluationGrp.value+ '&p_3=' + lst_MBO_Status.value+'&p_4='+lst_Final_Status.value+'&p_5='+lst_Emp.value +'&p_6='+txtemp.text;
                url+='&p_7='+lstMng_Level.value+'&p_8='+lstMng.value+'&p_9='+txtTemp_MNG.text+'&p_10='+lstEvaMaster.GetText();
            window.open(url);  
        }
        function onAddNew()
        {
        }
        function onSave()
        {
        }
        function OnSearch()
        {
			HR_SEL_CHEM00290_V2_01.Call();
        }
        function onDelete()
        {
        }

		function onOpenPopup()
		{
			var ctrl=idGrid.GetGridControl();
			var write_yn="";
			var p_data;
			var l_col=ctrl.col;
			var l_row=ctrl.row;
			
			if(l_col==idGrid_Action_Plan || l_col==idGrid_Target1 || l_col==idGrid_Target2)
			{
				write_yn="N";

				txtArea_Tmp.SetDataText(idGrid.GetGridData(l_row,l_col));

				if(l_col==idGrid_Action_Plan)
					p_data="MBO RESULT";
				else if(l_col==idGrid_Target1)
					p_data="TARGET FIRST 6 MONTHS";
				else if(l_col==idGrid_Target2)
					p_data="TARGET LAST 6 MONTHS";

				//alert(write_yn);
				var path = System.RootURL + '/form/ch/em/chem00060_v2_1.aspx?p_data='+p_data+"&write_yn="+write_yn;
				var object = System.OpenModal(path ,700 , 500 , 'resizable:yes;status:yes',window);
			}

		}
		function GetContent()
		{
			return txtArea_Tmp.GetData();
		}
    </script>
    <body style=" margin-bottom:0; margin-top:0; margin-right:0; margin-left:0" >
    <!-------------------data control----------------------->

	<gw:data id="dso_Period" onreceive="OnDataReceive(this)"  > 
			<xml> 
				<dso  type="process" procedure="HR_pro_chem00001_V2" > 
					<input>
						<input bind="lstEvaMaster"/>  
					</input> 
					<output>
						<output bind="txtNumOfLevel" />
					</output>
				</dso> 
			</xml> 
	</gw:data>

	<gw:data id="dso_Eva_Level" onreceive="OnDataReceive(this)"  > 
			<xml> 
				<dso  type="list" procedure="HR_pro_chem00000_v2_level" > 
					<input>
						<input bind="lstEvaMaster"/> 
					</input> 
					<output>
						<output bind="txtLevel" />
					</output>
				</dso> 
			</xml> 
	</gw:data>

	<gw:data id="dso_Eva_Group" onreceive="OnDataReceive(this)"  > 
			<xml> 
				<dso  type="list" procedure="HR_pro_chem00000_v2_grp" > 
					<input>
						<input bind="lstEvaMaster"/> 
					</input> 
					<output>
						<output bind="txtEvaGrp" />
					</output>
				</dso> 
			</xml> 
	</gw:data>

    <!------------------------------------------>
    <gw:data id="HR_SEL_CHEM00290_V2_01" onreceive="OnDataReceive(this)" > 
            <xml> 
                <dso  type="grid"  parameter="0,1,2,10,12,13,14" function="HR_SEL_CHEM00290_V2_01"> 
                    <input bind="idGrid" >
                        <input bind="lstEvaMaster" />   
						<input bind="lstEvaluationGrp" />
						<input bind="lst_MBO_Status" />  
						<input bind="lst_Final_Status" />   
						<input bind="lst_Emp" /> 
						<input bind="txtemp" /> 
						<input bind="lstMng_Level" />   
						<input bind="lstMng" /> 
						<input bind="txtTemp_MNG" />						
                    </input>
                    <output  bind="idGrid" />
                </dso> 
            </xml> 
    </gw:data>

    <!-------------------data control----------------------->

      <table name="Language Management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
            <tr style="width:100%;height:100%" valign="top">
                <td>
                   <table width="100%" id="tblexp" style="height:100%; font-size:9px" border=1 cellpadding="0" cellspacing="0">
                        <tr style="border:0;width:100%;height:1%" valign="center" >
                            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                        </tr>              
						<tr style="border:0;width:100%;height:5%" valign="center" >
                            <td colspan=7 style="border:0;" align="right" >Eva.Term </td>
                            <td colspan=15 style="border:0">
					            <gw:list  id="lstEvaMaster" styles='width:100%' onchange="OnChangeEvaPeriod()""> 
							            <data><%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where del_if=0 order by 2 desc")%></data> 
					            </gw:list>
				            </td>
                           
                            <td colspan=10 style="border:0;" align="right" >Eva.Group</td>
                            <td colspan=15  style="border:0;" align="left" >
                                <gw:list  id="lstEvaluationGrp" styles='width:100%'></gw:list>
                            </td>
                            <td colspan=7 style="border:0;" align="right">MBO.Status</td>
				            <td colspan=15 style="border:0;">
                                <gw:list id="lst_MBO_Status" value="ALL" styles='width:100%' onchange=""> 
							            <data><%=ESysLib.SetListDataSQL("SELECT  V.CODE,V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0102'")%>|ALL|Select All</data>
					            </gw:list>
							</td>				            
                            <td colspan=10 style="border:0;" align="right">Final Status</td>
				            <td colspan=15 style="border:0;">
                                <gw:list  id="lst_Final_Status" value="ALL" styles='width:100%' onchange=""> 
							             <data><%=ESysLib.SetListDataSQL("SELECT V.CODE,V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0103'")%>|ALL|Select All</data>
					            </gw:list></td>
                            </td>
				            <td colspan=6 style="border:0;"></td>
                        </tr>
                        <tr style="border:0;width:100%;height:5%" valign="center" >                            
                            <td colspan=7 style="border:0;" align="right" >Employee</td>
                            <td colspan=5 style="border:0">
					            <gw:list  id="lst_Emp" value="2" styles='width:100%' onchange=""> 
							            <data>LIST|1|Name|2|ID</data> 
					            </gw:list>
				            </td>
                            <td colspan=10 style="border:0"> 
					            <gw:textbox id="txtemp" onenterkey="OnSearch()" styles="width:100%"/>
				            </td>
							<td colspan=6 style="border:0;" align="right" >Manager</td>
							<td colspan=6 style="border:0">
					            <gw:list  id="lstMng_Level" value="2" styles='width:100%' onchange=""> 
							            <data>LIST|1|Level 1|2|Level 2</data> 
					            </gw:list>
				            </td>
                            <td colspan=6 style="border:0">
					            <gw:list  id="lstMng" value="2" styles='width:100%' onchange=""> 
							            <data>LIST|2|Name|1|ID</data> 
					            </gw:list>
				            </td>							
                            <td colspan=7 style="border:0"> 
					            <gw:textbox id="txtTemp_MNG" onenterkey="OnSearch()" styles="width:100%"/>
				            </td>
                            <td colspan=7 style="border:0;" align="right" >Report</td>
                            <td colspan=15  style="border:0;" align="left" ><gw:list  id="lstReport" maxlen = "100" styles='width:100%' >
                                <data><%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chem00290_v2' and char_4='1' order by seq")%></data>
								</gw:list>
                            </td>
                            <td colspan=1 align="right" style="border:0"></td>
                            <td colspan=2 style="border:0">
                                <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onReport()" />
                            </td>  
                            <td colspan=8 style="border:0" align="right" >
                                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                            </td>
                             <td colspan=10 align="center" style="border:0">
                                <gw:label id="lblRecord" style="font-weight: bold; color: red; font-size: 12" text="0 row(s)" />
                            </td>                         
                            
                        </tr>                        
                               
                       <tr style="border:1;width:100%;height:79%" valign="top">
                            <td colspan=100 style="width:100%;height:100%;"> 
                                 <gw:grid   
                                    id="idGrid"  
                                    header="Organization|_Eva Period|Eva Group|Emp ID|Full Name|Manager 1|Manager 2|MBO Status|MBO Closed Y/N|Final Status|Closed Y/N|Action Plan|Target 1|Target 2|Weight|Self Score|Score 1|Score 2|Final Score|_MBO_PK|_EVA_YYYY|_EVA_SEQ"
                                    format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                    aligns  ="0|0|0|1|0|0|0|0|1|0|1|0|0|0|1|1|1|1|1|0|0|0"
                                    defaults="|||||||||||||||||||||"
                                    editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                    widths="1500|0|1500|900|2800|2800|2800|1300|1500|1800|1000|2700|1700|1700|1000|1000|1000|1000|1000|1000|1000|1000"
                                    styles="width:100%; height:100%" oncelldblclick="onOpenPopup()"
                                    sorting="T"/> 
                            </td>
                        </tr>
                   </table> 
                </td>
            </tr>
        </table>	 
    </body>
	<gw:textbox id="txtEvaGrp" style="display:none" />
	<gw:textbox id="txtLevel" style="display:none" />
	<gw:textbox id="txtResult" style="display:none" />
	<gw:textbox id="txtAction" style="display:none" />
	<gw:textbox id="txtNumOfLevel" style="display:none" />
	<gw:textarea id="txtArea_Tmp"  text="" onchange="" styles='width:100%;display:none'/>
</html>
