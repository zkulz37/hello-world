<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>APPOINTMENT ENTRY</title>
</head>
<%  ESysLib.SetUser("HR")%>

<script>
var  user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;
var flag;

var G1_tco_org_pk  = 0,
    G1_Org_ID      = 1,
    G1_Org_Name    = 2,
    G1_PK          = 3,
    G1_Emp_ID      = 4,
    G1_Emp_Name    = 5,
    G1_Position    = 6;
    G1_Manager_pk  = 7;
    G1_Basic_Salary = 8;
    
var G2_PK       = 0,
    G2_Slip_No  = 1,
    G2_Date     = 2,
    G2_Status   = 3,
    G2_Org      = 4;
//-------------------
var G3_PK                   = 0,
    G3_THR_APPOINTMENT_PK   = 1,
    G3_App_NO               = 2,
    G3_THR_EMPLOYEE_PK      = 3,
    G3_Emp_ID               = 4,
    G3_Emp_Name             = 5,
    G3_FROM_ORG_PK         = 6,
    G3_From_Org_ID         = 7,
    G3_From_Org_NM         = 8,
    G3_From_Manager_Name     = 9
    G3_From_Position       = 10,
    G3_Old_Salary          = 11,    
    G3_TO_ORG_PK           = 12,
    G3_To_Org_ID           = 13,
    G3_To_Org_NM           = 14,
    G3_To_Manager_Name       = 15
    G3_To_Position          = 16,
    G3_New_Salary           = 17,
    G3_App_Date             = 18,
    G3_Status               = 19,
    G3_Execute_DT           = 20,
    G3_Description          = 21;
 
 //---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="65%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }              
//--------------------------------------------------------------------- 

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    //---------------------------------- 

    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------------- 
    
    txtSlipNo.SetEnable(false);    
    lstStatus.SetEnable(false);
    txtChargerName.SetEnable(false);
    
    lstPosition.SetEnable(false);
    txtManager_ID.SetEnable(false);
    txtManager_Name.SetEnable(false);   
    //-------------------------
    BindingDataList();
    SetGridFormat();
    
    idAddNew.SetEnable(0);
    iduser_pk.text = "<%=session("USER_PK")%>";
    datSal_security.Call();
}
//---------------------------------------------------------------------  
function OnShowPopup(obj1)
{
    var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
			obj1.value = obj;
            //txtUpperOrg.text=obj;
            //datOrgData.Call();
            
        }
}
//-------------------------------------------
 function BindingDataList()
 {      
     var data ;
     
     data = "<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>||";   
     
     lstPosition.SetDataText(data);
     lstPosition.value = '' ;
     //-----------------------
     
     data = "data|10|Saved|20|Executed";
     lstStatus.SetDataText(data);
     //----------------------- 
         
     data = "<%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where  del_if=0 order by NVL(SEQ,99999)")%>";   
     
     lstOrg.SetDataText( data );
     lstOrgSearch1.SetDataText( data + "|ALL|Select ALL");
     lstOrgSearch1.value = 'ALL' ;     
     lstOrgSearch2.SetDataText( data + "|ALL|Select ALL");     
     lstOrgSearch2.value = 'ALL' ;
     //-----------------------
     
     data = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by NVL(SEQ,99999) " ) %> ";       
     grdEmpList.SetComboFormat( G1_Position, data);
     
     grdDetail.SetComboFormat( G3_From_Position, data); 
     grdDetail.SetComboFormat( G3_To_Position, data);    
 
     data = "<%=ESysLib.SetGridColumnDataSQL("select pk,org_nm from comm.tco_org a where del_if=0 order by NVL(SEQ,99999) " ) %> ";       
     grdAppList.SetComboFormat( G2_Org, data);
     
     data = "<%=ESysLib.SetGridColumnDataSQL("select '10', 'Saved' from dual union all select '20', 'Executed' from dual " ) %> ";       
     grdAppList.SetComboFormat( G2_Status, data); 
     
     data = "<%=ESysLib.SetGridColumnDataSQL("select '10', 'Saved' from dual union all select '20', 'Executed' from dual " ) %> ";       
     grdDetail.SetComboFormat( G3_Status, data);                        
 }
 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
    var ctrl = grdEmpList.GetGridControl();
    
    ctrl.MergeCells  = 2 ;	
    ctrl.MergeCol(0) = true ;	
    ctrl.MergeCol(1) = true ;   	
    ctrl.MergeCol(2) = true ;	
    ctrl.MergeCol(3) = true ;	     
    
 }

//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtChargerName.text = obj[2];
                txtChargerPK.text   = obj[0];
            }
        break; 
    }	       
}

//-------------------------------------------------------------------------------------
/*function TestMadeApp()
{ 
    txtResult.text="";
    txtEmpPK.text=grdEmpList.GetGridData( grdEmpList.row, G1_PK ) ;
    da_check_made_app.Call();
}*/
/*function OnGridCellDoubleClick()
{ 

                var event_col = grdEmpList.col ;
                var event_row = grdEmpList.row ;
             for(var i=1;i<grdDetail.rows;i++)
                    if(grdDetail.GetGridData( i,G3_THR_EMPLOYEE_PK )==grdEmpList.GetGridData( grdEmpList.row, G1_PK ))
                        {   alert("Employee existed in grid .Please select other !");
                            return;
                        }
             
                if ( event_row > 0 )
                {
                    grdDetail.AddRow();
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G3_THR_EMPLOYEE_PK, grdEmpList.GetGridData( event_row, G1_PK       ) );
                    grdDetail.SetGridText( grdDetail.rows-1, G3_Emp_ID,          grdEmpList.GetGridData( event_row, G1_Emp_ID   ) );
                    grdDetail.SetGridText( grdDetail.rows-1, G3_Emp_Name,        grdEmpList.GetGridData( event_row, G1_Emp_Name ) );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G3_FROM_ORG_PK,    grdEmpList.GetGridData( event_row, G1_tco_org_pk ) );
                    grdDetail.SetGridText( grdDetail.rows-1, G3_From_Org_ID,    grdEmpList.GetGridData( event_row, G1_Org_ID     ) );
                    grdDetail.SetGridText( grdDetail.rows-1, G3_From_Org_NM,    grdEmpList.GetGridData( event_row, G1_Org_Name   ) );
                    grdDetail.SetGridText( grdDetail.rows-1, G3_From_Position,  grdEmpList.GetGridData( event_row, G1_Position   ) );
                    grdDetail.SetGridText( grdDetail.rows-1, G3_App_Date,       dtDocDate.value );
                                
                    grdDetail.SetGridText( grdDetail.rows-1, G3_TO_ORG_PK,  lstOrg.value     );
                    grdDetail.SetGridText( grdDetail.rows-1, G3_To_Org_NM,     lstOrg.GetText() );                          
                }
                //------------------------

                grdDetail.GetGridControl().AutoSize( 0, G3_Description, false, 0 );
                 
                
}   
 */
//---------------------------------------------------------------------------------------------------
  
function OnNew()
{
    idAddNew.SetEnable(1);
    
    data_chae00170_2.StatusInsert();

    //-------------------------------------------
    txtChargerName.text = "<%=Session("USER_NAME")%>";
    txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
    //------------------------------------------- 
    grdDetail.ClearData();
    
    flag="view"; 
}  
//---------------------------------------------------------------------------------------------------

function OnAddNewEmp()
{
    var control = grdEmpList.GetGridControl();
    var rows = control.rows;
    txtEmpPK.text="";
    //alert(grdEmpList.GetGridControl().SelectedRow(1)+"");      
	for (var i=0;i< control.SelectedRows ; i++)
	    {   if(i!=0) 
	            {txtEmpPK.text=txtEmpPK.text+",";
	            
	            }
	      
	    txtEmpPK.text=txtEmpPK.text+ grdEmpList.GetGridData( control.SelectedRow(i)+"", G1_PK )+"";
	    //  alert( grdEmpList.GetGridControl().SelectedRow(i));  
	    //alert(txtEmpPK.text);
	    }
	     da_check_made_app.Call();
}
function OnAddNewEmpSetGrid()
{	var control = grdEmpList.GetGridControl();
    var rows = control.Rows;
    var flag=0;
    for (i=0; i<control.SelectedRows ; i++)
	{   flag=0;
	    var event_row = control.SelectedRow(i);
	    for(j=0;j<grdDetail.rows;j++)
	        {
	            if(grdDetail.GetGridData( j,G3_THR_EMPLOYEE_PK )==grdEmpList.GetGridData(event_row, G1_PK ))
	            {flag=1;
	            break;
	            }
	        }
	        if(flag==0)
	        {  if(grdDetail.rows<=1)
	            OnNew();
	            grdDetail.AddRow();
                grdDetail.SetGridText( grdDetail.rows-1, G3_THR_EMPLOYEE_PK, grdEmpList.GetGridData( event_row, G1_PK       ) );
                grdDetail.SetGridText( grdDetail.rows-1, G3_Emp_ID,          grdEmpList.GetGridData( event_row, G1_Emp_ID   ) );
                grdDetail.SetGridText( grdDetail.rows-1, G3_Emp_Name,        grdEmpList.GetGridData( event_row, G1_Emp_Name ) );
                
                grdDetail.SetGridText( grdDetail.rows-1, G3_FROM_ORG_PK,    grdEmpList.GetGridData( event_row, G1_tco_org_pk  ) );
                grdDetail.SetGridText( grdDetail.rows-1, G3_From_Org_ID,    grdEmpList.GetGridData( event_row, G1_Org_ID      ) );
                grdDetail.SetGridText( grdDetail.rows-1, G3_From_Org_NM,    grdEmpList.GetGridData( event_row, G1_Org_Name    ) );
                grdDetail.SetGridText( grdDetail.rows-1, G3_From_Manager_Name,    grdEmpList.GetGridData( event_row, G1_Manager_pk    ) );
                grdDetail.SetGridText( grdDetail.rows-1, G3_Old_Salary,    grdEmpList.GetGridData( event_row, G1_Basic_Salary    ) );
                
                grdDetail.SetGridText( grdDetail.rows-1, G3_From_Position,  grdEmpList.GetGridData( event_row, G1_Position    ) );
                grdDetail.SetGridText( grdDetail.rows-1, G3_App_Date,       dtDocDate.value );
                
                
                grdDetail.SetGridText( grdDetail.rows-1, G3_TO_ORG_PK,  lstOrg.value     );
                grdDetail.SetGridText( grdDetail.rows-1, G3_To_Org_NM,  lstOrg.GetText() );  
                grdDetail.SetGridText( grdDetail.rows-1, G3_To_Manager_Name,    txtManager_PK.text );
                grdDetail.SetGridText( grdDetail.rows-1, G3_New_Salary,    grdEmpList.GetGridData( event_row, G1_Basic_Salary    ) );      
	        }
	}
    //------------------------

   grdDetail.GetGridControl().AutoSize( 0, G3_Description, false, 0 );

}
//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdEmpList':
            data_chae00170.Call("SELECT");
        break;

        case 'grdAppList':
            data_chae00170_1.Call("SELECT");
        break;
            
        case 'grdMaster':
            if ( data_chae00170_1.GetStatus() == 20 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdAppList.row > 0 )
                    {
                        txtMasterPK.text = grdAppList.GetGridData( grdAppList.row, G2_PK );
                    }
                    else
                    {
                        txtMasterPK.text = '';
                    }
                    
                    flag = 'view' ;
                    data_chae00170_2.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdAppList.row > 0 )
                {
                    txtMasterPK.text = grdAppList.GetGridData( grdAppList.row, G2_PK );
                }
                else
                {
                    txtMasterPK.text = '';
                }  
                              
                flag = 'view' ;
                data_chae00170_2.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_chae00170_4.Call("SELECT");
        break;
        
        case 'ManagerList':            
            data_chae00170_3.Call("SELECT");
        break;        
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_chae00170_2": 
                   
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G3_THR_APPOINTMENT_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G3_THR_APPOINTMENT_PK, txtMasterPK.text);
                    }    
                }
                
                OnSave('Detail');                
            }
            else
            {
                //---------------------------- 
                OnSearch('grdDetail');   
            }
            
        break;
        
        case "data_chae00170_4":
            //------------------------
            if ( grdDetail.rows >= 2 )
            {
  		        grdDetail.SetCellBgColor(1, G3_FROM_ORG_PK, grdDetail.rows - 1, G3_From_Position, 0xCCFFFF );
  		        grdDetail.SetCellBgColor(1, G3_TO_ORG_PK,   grdDetail.rows - 1, G3_To_Position,   0xd4d2ff );
            }
  		    //------------------------
        
            grdDetail.GetGridControl().AutoSize( 0, G3_Description, false, 0 );
                            
            if ( flag != 'view' ) 
            {   
                OnSearch('grdAppList');
            }    
        break;
 
        case "data_chae00170_3":
            //------------------------
          //  data_chae00170.Call();   
        break;        
        case "da_check_made_app":
            if(txtResult.text=='1')
            alert("Employee appointments existed. Please select other entry ");
            else
            { OnAddNewEmpSetGrid();
             }
        break;
        case "da_check_del_app":
            if(txtResult.text=='1')
            {alert("Employee appointment executeted !. You can't delete");
            grdDetail.UnDeleteRow(); 
            }
            else
            {
                grdDetail.DeleteRow(); 
            
            }
        break;
        
        case "datSal_security":
           if(txt_sal_security.text=='N') 
           {
                    grdDetail.GetGridControl().ColHidden(G3_Old_Salary)=1;
                    grdDetail.GetGridControl().ColHidden(G3_New_Salary)=1;
           }

        break;
        
    }
}

//------------------------------------------------------------------------------------------------

 function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this App?'))
            {
                flag='delete';
                data_chae00170_2.StatusDelete();
               data_chae00170_2.Call();
                
            }   
        break;

        case 'Detail':
            if(confirm('Do you want to delete this Emp?'))
            {
           
                if ( grdDetail.GetGridData( grdDetail.row, G3_PK ) == '' )
                {grdDetail.RemoveRow();  
                    
                }
                else
                {   var t=1;
                txtEmpPK.text="";
               //alert(grdDetail.GetGridControl().SelectedRows+"");
                for (var i=0;i<grdDetail.GetGridControl().SelectedRows;i++)
                    {  // alert("aaaa");
                    if(i!=0)
                        txtEmpPK.text=txtEmpPK.text+",";
                        txtEmpPK.text=txtEmpPK.text+ grdDetail.GetGridData(grdDetail.GetGridControl().SelectedRow(i), G3_THR_EMPLOYEE_PK)+"";
                                
                    }
                //alert(txtEmpPK.text);
                da_check_del_app.Call();
                     
                }    
            }            
        break;            

    }     
}
//------------------------------------------------------------------------------------- 
 
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}
//-------------------------------------------------------------------------------------

function Validate()
{   
    //---------------
    for( var i = 1; i < grdDetail.rows; i++)
    {
        //---------------
        if ( grdDetail.GetGridData(i, G3_FROM_ORG_PK) == grdDetail.GetGridData(i, G3_TO_ORG_PK) && grdDetail.GetGridData(i, G3_From_Position) == grdDetail.GetGridData(i, G3_To_Position) )
        {
            alert("This Employee : " + grdDetail.GetGridData(i, G3_Emp_Name) + " didn't change anything!")
            return false;
        }
        //---------------
    }
    //----------------
    return true;
}

//-------------------------------------------------------------------------------------
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_chae00170_2.Call();
                flag='save';
            }            
        break;
        case 'Detail':        
            data_chae00170_4.Call();
        break;
    }
}

//--------------------------------------------------------------------- 

</script>

<body>
    <!-- Kiem tra quyen xem luong ---------------------------------------->
    <gw:data id="datSal_security" onreceive="OnDataReceive(this)"  > 
            <xml>
                <dso  type="process" procedure="hr.sp_pro_sal_display"  > 
                    <input>
                        <input bind="iduser_pk" />
                    </input> 
                    <output>
                        <output bind="txt_sal_security" />
                    </output>
                </dso> 
            </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chae00170" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso id="1" type="grid" user="prod" function="hr.sp_sel_chae00170" >
                <input  bind="grdEmpList">
                    <input bind="lstOrgSearch1" />
                    <input bind="txtEmpSearch" />
                </input> 
                <output bind="grdEmpList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chae00170_1" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso id="1" type="grid" user="prod" function="hr.sp_sel_chae00170_1" >
                <input  bind="grdAppList">
                    <input bind="lstOrgSearch2" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                </input> 
                <output bind="grdAppList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chae00170_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" function="hr.sp_sel_chae00170_2" procedure="hr.sp_upd_chae00170_2">
                <input>
                    <inout bind="txtMasterPK" />
                    <inout bind="txtSlipNo" />
                    <inout bind="dtDocDate" />
                    <inout bind="txtChargerPK" />
                    <inout bind="txtChargerName" />
                    <inout bind="lstStatus" />
                    <inout bind="txtDescription" />
                    <inout bind="lstOrg" />
                    <inout bind="txtManager_PK" />
                    <inout bind="txtManager_ID" />                    
                    <inout bind="txtManager_Name" />
                    <inout bind="lstPosition" />
                </input>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chae00170_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="hr.sp_sel_chae00170_3" procedure="hr.sp_upd_chae00170_3">
                <input>
                    <inout bind="lstOrg" />
                    <inout bind="txtManager_PK" />
                    <inout bind="txtManager_ID" />
                    <inout bind="txtManager_Name" />
                    <inout bind="lstPosition" />
                </input>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chae00170_4" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso id="1" type="grid" user="hr" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="hr.sp_sel_chae00170_4" procedure="hr.sp_upd_chae00170_4" >
                <input  bind="grdDetail">
                    <input bind="txtMasterPK" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------------->
    <gw:data id="da_check_made_app" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.check_made_app" > 
                <input>
                    <input bind="txtEmpPK" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
     <gw:data id="da_check_del_app" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.check_del_app" > 
                <input>
                
                    <input bind="txtMasterPK" /> 
                    <input bind="txtEmpPK" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td id="left" style="width: 35%">
                <!-- <gw:tab id="tab"> -->
                <gw:tab id="tab">
                <table style="width: 100%; height: 100%" name="App List">
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            Date
                        </td>
                        <td style="width: 79%">
                            <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch2" img="search" alt="Search" text="Search" onclick="OnSearch('grdAppList')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                             <a title="Click here to show Organization" onclick="OnShowPopup(lstOrgSearch2)" href="#tips" >Organization</a>
                        </td>
                        <td colspan="2" align="left">
                            <gw:list id="lstOrgSearch2" styles="width: 100%" onchange="OnSearch('grdAppList')" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <gw:grid id='grdAppList' header='_PK|Slip No|Date|Status|Org' format='0|0|4|0|0'
                                aligns='0|0|1|0|0' defaults='||||' editcol='0|0|0|0|0' widths='0|1500|1200|1200|1000'
                                sorting='T' styles='width:100%; height:100%' onclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>                
                <table style="width: 100%; height: 100%" name="Emp List">
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            Employee
                        </td>
                        <td style="width: 79%">
                            <gw:textbox id="txtEmpSearch" styles="width: 100%" csstype="mandatory" onenterkey="OnSearch('grdEmpList')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdEmpList')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                             <a title="Click here to show Organization" onclick="OnShowPopup(lstOrgSearch1)" href="#tips" >Organization</a>
                            </td>
                        <td align="left">
                            <gw:list id="lstOrgSearch1" styles="width: 100%" onchange="OnSearch('grdEmpList')" />
                        </td>
                        <td>
                            <gw:imgbtn id="idAddNew" img="new" alt="Add New" onclick="OnAddNewEmp()" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <gw:grid id='grdEmpList' header='_TCO_ORG_PK|Org ID|Org Name|_PK|Emp ID|Emp Name|Position|_Manager_PK|_Salary'
                                format='0|0|0|0|0|0|0|0|' aligns='0|0|0|0|0|0|0|0|0' defaults='||||||||' editcol='0|0|0|0|0|0|0|0|0'
                                widths='0|1000|1500|1000|1000|2000|1000|1000|1000' sorting='T' styles='width:100%; height:100%'
                                />
                        </td>
                    </tr>
                </table>
                </gw:tab>
                <!-- </gw:tab> -->
            </td>
            <td id="right" style="width: 65%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            Slip No
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtSlipNo" styles="width: 100%" csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 10%">
                            Status
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstStatus" styles="width: 100%" />
                        </td>
                        <td align="right" style="width: 10%">
                            Date
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtDocDate" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 6%" align="right">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDeleteMST" img="delete" alt="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSaveMST" img="save" alt="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            Remark
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtDescription" styles="width:100%;" />
                        </td>
                        <td align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Charger')">Charger </b>
                        </td>
                        <td colspan="6">
                            <gw:textbox id="txtChargerName" styles="width:100%" />
                            <gw:textbox id="txtChargerPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            <a title="Click here to show Organization" onclick="OnShowPopup(lstOrg)" href="#tips" >Organization</a>
                        </td>
                        <td colspan="3">
                            <gw:list id="lstOrg" styles="width: 100%" onchange="OnSearch('ManagerList')" />
                        </td>
                        <td align="right">
                          
                        </td>
                        <td colspan="6">
                            
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            Manager</td>
                        <td>
                            <gw:list id="lstPosition" styles="width: 100%" />
                        </td>
                        <td colspan="9">
                            <gw:textbox id="txtManager_ID" styles="width:20%" />
                            <gw:textbox id="txtManager_Name" styles="width:80%" />
                            <gw:textbox id="txtManager_PK" styles="display:none" />
                        </td>
                    </tr>                   
                    <tr style="height: 1%">
                        <td style="width: 10%" align="left">
                            <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand"
                                onclick="OnToggle()" />
                        </td>
                        <td>
                        </td>
                        <td align="right">
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnDeleteDTL" img="delete" alt="Delete" onclick="OnDelete('Detail')" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnUnDeleteDTL" img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 93%">
                        <td colspan="11">
                            <gw:grid id='grdDetail' 
                                header='_PK|_THR_APPOINTMENT_PK|App NO|_THR_EMPLOYEE_PK|Emp ID|Emp Name|_FROM_DEPT_PK|From Org|Name|From Manager|From Position|Old Salary|_TO_DEPT_PK|To Org|Name|To Manager|To Position|New Salary|App Date|Status|Execute DT|Description'
                                format='0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|1|4|0|4|0' 
                                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                defaults='|||||||||||||||||||||' 
                                editcol='0|0|1|0|0|0|0|0|0|0|0|1|0|0|0|0|0|1|1|0|0|1'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%' acceptnulldate='T' oncelldblclick="" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
    <gw:textbox id="txtEmpPK" styles="width: 100%;display:none" />
    <gw:textbox id="txtResult" styles="width: 100%;display:none" />
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txt_sal_security" styles="display:none"/>
    <!------------------------------------------->
</body>
</html>
