<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>APPOINTMENT EXECUTE</title>
</head>
<%  ESysLib.SetUser("HR")%>

<script>
var  user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;
var Arr
var idx;
var startTime,interval_time;
function BodyInit()
{

    System.Translate(document);  // Translate to language session
    iduser_pk.text = "<%=session("EMPLOYEE_PK")%>";
    ibtnSend.SetEnable(0);
    
   
    OnChangeTitile();
     
}

function OnClear()
{
 txtSubject.text='';
 txtContent.SetDate('');
 
}

function OnSend()
{ if(lstTitle.value!='1')
        {//alert(txtContent.GetData() + " --  " + txtSubject.text)
        if(txtContent.GetData()==''|| txtSubject.text=='')
            {alert("Please input Subject and Content");
            return;
            }
        }
  
  
  for (var i=1;i<grdEmployee.rows;i++)
           grdEmployee.SetGridText(i,7,'');
           
  alert("Please waiting mail sending.");
  clear_Interval(idInterval);
  idx=0;
  txtEmpPk.text=Arr[idx][0];
  txtMailOption.text=Arr[idx][1];
  set_Interval(100);
  datSendMail.Call();
  
        
}
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
function OnDataReceive(obj)
{ if(obj.id='datSendMail')
    {   
    
    if(lstTitle.value=='2' && txtResult.text!='Error')//send other
    { 
    clear_Interval(idInterval);
           idInterval.text="Sending finished.";    
           for (var i=1;i<grdEmployee.rows;i++)
            {if(grdEmployee.GetGridData(i,2)=='-1'||grdEmployee.GetGridData(i,1)=='-1')
                {grdEmployee.SetGridText(i,7,txtResult.text);}
            }   
           return;  
    }
    if(lstTitle.value=='2' && txtResult.text=='Error')//send other
    {if(confirm("Have error when sending mail. \n Click 'OK' if you want to try again or 'Cancel' ignore")==true)
               {
                datSendMail.Call();
                }
                clear_Interval(idInterval);
                return;
    }
    
    
    if(grdEmployee.GetGridData(Arr[idx][2],0)==Arr[idx][0])// khong co ai order by lai
                grdEmployee.SetGridText(Arr[idx][2],7,txtResult.text);
         else
         {for (var i=1;i<grdEmployee.rows;i++)
            {if(grdEmployee.GetGridData(i,0)==Arr[idx][0])
                {grdEmployee.SetGridText(i,7,txtResult.text); break;}
            }
         }
         if(txtResult.text=='Error' && idx <= Arr.length-1)
         {if(confirm("Have error when sending mail to " + Arr[idx][3]+"\n Click 'OK' if you want to try again or 'Cancel' ignore and continute ")==true)
               {
                datSendMail.Call();
                return;
               }
         }
         
         if(idx < Arr.length-1   )
            {//alert(Arr.length);
             idx=idx+1;
             txtEmpPk.text=Arr[idx][0];
             txtMailOption.text=Arr[idx][1];
             datSendMail.Call();
            }
         if(idx==Arr.length-1)
          {
           clear_Interval(idInterval);
           idInterval.text="Sending finished.";       
           return;  
          }
       
    }
}

function OnChangeTitile()
{  
OnClickRow();
 if(lstTitle.value=='1')
        { txtSubject.SetEnable(0);
          txtContent.SetEnable(0);
          txtContent.SetData('');
          txtSubject.text='PAY SLIP ON '+ dtMonth.text;
          grdEmployee.GetGridControl().ColHidden(2)=1;  
          chkCC.value='F';
          chkCC.SetEnable(0);  
          idlbCC.text='';     
          ibtnClear.SetEnable(0);
          idlbCC.style.display="none";
          dtMonth.SetEnable(1);
        }
     else
        { txtSubject.SetEnable(1);
          txtContent.SetEnable(1);
          ibtnClear.SetEnable(1);
          txtSubject.text='';
          grdEmployee.GetGridControl().ColHidden(2)=0;  
           chkCC.SetEnable(1); 
           idlbCC.style.display="";  
           dtMonth.SetEnable(0);    
        
        }
        
        
    
}
function OnSearch()
{
     idlbTo.text='0';   
    idlbCC.text='0';
    datEmployee_Main_Search.Call("SELECT");
}
function OnClickRow()
{
Arr  =new Array();
idx=0;
var to='';
 var cc='';
 var lstpk='';
 var lstpkCC='';
 var num_to=0;
 var num_cc=0;
 
 for (var i=1;i<grdEmployee.rows;i++)
       {    if(grdEmployee.GetGridData(i,1)=="-1" )
                {   to=to+grdEmployee.GetGridData(i,8)+"("+grdEmployee.GetGridData(i,4)+")<"+grdEmployee.GetGridData(i,6)+ ">;";
                    num_to=num_to+1;
                    Arr[idx]=new Array();
                    Arr[idx][0]=grdEmployee.GetGridData(i,0);//pk
                    lstpk=lstpk+grdEmployee.GetGridData(i,0)+",";
                    Arr[idx][1]='1';//to
                    Arr[idx][2]=i;//idx grid
                    Arr[idx][3]=grdEmployee.GetGridData(i,3)+"("+grdEmployee.GetGridData(i,4)+")";//idx grid
                    idx++;
                // grdEmployee.SetGridText(i,11,lstTitle.value+"");
                 //grdEmployee.SetGridText(i,12,dtMonth.value);
                }
             if(grdEmployee.GetGridData(i,1)=='-1' && grdEmployee.GetGridData(i,2)=='-1')   
             {alert("Can't choose option CC and To at the same time ");
              grdEmployee.SetGridText(i,2,'0');
             }
               if(grdEmployee.GetGridData(i,2)=="-1" )
                {
                if(Number(lstTitle.value)!=1)
                    {  cc=cc+grdEmployee.GetGridData(i,8)+"("+grdEmployee.GetGridData(i,4)+")<"+grdEmployee.GetGridData(i,6)+ ">;";
                    num_cc=num_cc+1; 
                    Arr[idx]=new Array();
                    Arr[idx][0]=grdEmployee.GetGridData(i,0);//pk
                    Arr[idx][1]='2';//cc
                    Arr[idx][2]=i;//idx grid
                    Arr[idx][3]=grdEmployee.GetGridData(i,3)+"("+grdEmployee.GetGridData(i,4)+")";//idx grid
                    lstpk=lstpk+grdEmployee.GetGridData(i,0)+",";
                    lstpkCC=lstpkCC+grdEmployee.GetGridData(i,0)+",";
                    idx++;      
                    }
                
                
                }   
           
       }
    // alert(num_cc);
  /*     if(num_to>0 || num_cc>0)
       {/*for (var i=1;i<grdEmployee.rows;i++)
           {   //////////////////////////// alert(cc);
             if(grdEmployee.GetGridData(i,1)=="-1" ||grdEmployee.GetGridData(i,2)=="-1" )
                       {
                            grdEmployee.SetGridText(i,7,to);
                            grdEmployee.SetGridText(i,8,cc);
                            grdEmployee.SetGridText(i,9,txtSubject.text);
                            grdEmployee.SetGridText(i,10,txtContent.text);
                       } 
      
           }
           ibtnSend.SetEnable(true);
       }*/
      if(num_to>0 || num_cc>0)
                ibtnSend.SetEnable(true);
       else
       ibtnSend.SetEnable(0);
    idlbTo.text=num_to;   
    idlbCC.text=num_cc;
    txtCC.text=cc;
    txtTo.text=to;
    txtlstPk.text=lstpk;
    txtlstPkCC.text=lstpkCC;
}
function OnCheck(obj)
{ 
var ctrl=grdEmployee.GetGridControl();
            for(var i=1;i<=ctrl.SelectedRows;i++)
                {
                        if(obj=="1")
                            {  
                              if(chkTo.value=="T" &&  grdEmployee.GetGridData(ctrl.SelectedRow(i-1),2)=='0')
                              grdEmployee.SetGridText(ctrl.SelectedRow(i-1),1,"-1");
                              else
                              grdEmployee.SetGridText(ctrl.SelectedRow(i-1),1,"0");
                              
                            }
                            
                        if(obj=="2")
                            {  
                              if(chkCC.value=="T" && grdEmployee.GetGridData(ctrl.SelectedRow(i-1),1)=='0')
                              grdEmployee.SetGridText(ctrl.SelectedRow(i-1),2,"-1");
                              else
                              grdEmployee.SetGridText(ctrl.SelectedRow(i-1),2,"0");
                            }    
                      
                }
    OnClickRow();
    
}
 function OnSearch1()
 {datHistory.Call();
 }
</script>

<body>

<!------------------------------------->
<!-------------------data control----------------------->
<gw:data id="datEmployee_Main_Search" > 
        <xml> 
            <dso  type="grid"   function="HR.SP_SEL_SEND_MAIL " > 
                <input bind="grdEmployee" >
                    <input bind="lstOrg" />
                    <input bind="dtFrom_JoinDate" />
                    <input bind="dtTo_JoinDate" />
                    <input bind="chkTemp" />
                    <input bind="txtTemp" />
					<input bind="lstNation" />
					<input bind="lstStatus" />
					<input bind="lstWplace" />
					<input bind="lstEmpType" />
				</input>
                <output  bind="grdEmployee" />
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datHistory" > 
        <xml> 
            <dso  type="grid"   function="HR.SP_SEL_SEND_MAIL_history " > 
                <input bind="grdSendMail" >
                    <input bind="lstTitle1" />
                    <input bind="dtSend_from" />
                    <input bind="dtSend_to" />
                    <input bind="chkTemp1" />
                    <input bind="txtTemp1" />
					<input bind="lstSendingStatus" />
					
				</input>
                <output  bind="grdSendMail" />
            </dso> 
        </xml> 
</gw:data>


<!------------------------------------->
<gw:data id="datSendMail" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_send_mail" > 
                <input>
                    <input bind="lstTitle" />
                    <input bind="dtMonth" />
                    <input bind="txtSubject" />
                    <input bind="txtContent" />
                    <input bind="txtMailOption" />
                    <input bind="txtEmpPk" />
                    <input bind="txtCC" /> 
                    <input bind="txtTo" /> 
                    <input bind="chkReceive" /> 
                    <input bind="iduser_pk" /> 
                    
                    <input bind="txtlstPk" /> 
                    <input bind="txtlstPkCC" /> 
                    
                    
                    
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>


   
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate=""  >   
  <table name="Send mail" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
    <tr>
    <td style="width:55%;height:100%">
        <table>
            
            <tr style="height:5%">
                <td style="width:20%; height:5%" align=right>Sender Receive</td>
                <td style="width:40%" align=left style="white-space:nowrap"><gw:checkbox id="chkReceive" value="T"  ></gw:checkbox >
                <gw:label id="idInterval" text="" styles="width:100%" ></gw:label>
                </td>
                <td style="width:20%" align=right><gw:icon id="ibtnClear" img="in" text="Clear" onclick="OnClear()" /></td>
                <td style="width:20%" align=right><gw:icon id="ibtnSend" img="in" text="Send Mail" onclick="OnSend()" /></td>
                
            </tr>
            <tr style="height:5%">
                <td style="width:20%; height:5%" align=right>Mail Title</td>
                <td style="width:40%" align=right><gw:list  id="lstTitle" value="01" maxlen = "10" styles='width:100%' onchange="OnChangeTitile()" > 
                            <data>
                                LIST|1|Pay Slip|2|Other
                            </data>
                            </gw:list></td>
                <td style="width:20%" align=right>Month</td>
                <td style="width:20%" align=right><gw:datebox id="dtMonth"  type="month" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"  onchange="OnChangeTitile()" /></td>
                
            </tr>
            <tr style="height:5%">
                <td style="width:20%; height:5%" align=right>Subject</td>
                <td colspan=3><gw:textbox  id="txtSubject"   text="" styles='width:100%'csstype="mandatory"  /></td>
           </tr>
            <tr style="height:75%">
                <td colspan=4 style="height:75%">
                <gw:textarea id="txtContent" styles='width:100%;height:500'  onkeypress="" csstype=""/></gw:textarea>
                </td>
            </tr>
            
            
        </table>
    </td>
    <td style="width:45%;height:100%">
         <table width="100%" height="100%" cellpadding=0 cellspacing=0 border=0 class="itable">
			    <tr   style="border:0;height:5%">
			        <td width="20%" style="border:0"  align="right" valign="middle">Nation</td>
				    <td colspan=2 width="25%" style="border:0" >
					    <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by seq")%>|ALL|Select All</data></gw:list>
				    </td>
				    <td width="16%" align=right>Status</td>
				    <td colspan=3 width="44%"><gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0022' order by seq" )%>|ALL|Select All</data></gw:list>
                     </td>
				    <td width=5%></td>
				    <td width=5%></td>
			    </tr>
			     <tr   style="border:0;height:5%">
			        <td width="20%" style="border:0"  align="right" valign="middle">Working place</td>
				    <td colspan=2 width="25%" style="border:0" >
					    <gw:list  id="lstWplace" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0115' order by seq")%>|ALL|Select All</data></gw:list>
				    </td>
				    <td width="16%" align=right>Emp type</td>
				    <td colspan=3 width="44%"><gw:list  id="lstEmpType" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by seq")%>|ALL|Select All</data></gw:list>
                     </td>
				    <td width=5%></td>
				    <td width=5%></td>
			    </tr>
				<tr style="border:0;height:5%">
			        <td style="border:0"  align="right" valign="middle"><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
				    <td style="border:0" colspan=6>
					    <gw:list  id="lstOrg" value="ALL" styles='width:100%' onchange="OnChangeOrg()"> 
					    <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0  order by NVL(a.seq,99999)")%>|ALL|Select All
                            </data></gw:list>
				    </td>
				    <td ></td>
				    <td ></td>
				    
				    
			    </tr>
			    
				<tr  style="border:0;height:5%" >
					<td  style="border:0" align="right">Join DT</td>
				    <td colspan=2 style="border:0" ><gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				    <td ></td>
				    <td colspan=4 style="border:0" ><gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				    <td colspan=2></td>
				    
				</tr>
				<tr  style="border:0;height:5%">
		            <td style="border:0" align="right" >Search by</td>
		            <td colspan=2 style="border:0">									
			            <gw:list  id="chkTemp" value="2" styles="color:blue;width:100%" onchange=""> 
					            <data> LIST|1|Full Name|2|Emp ID|3|Card ID|4|Person ID</data> 
			            </gw:list>
		            </td>
		            <td colspan=4 style="border:0"><gw:textbox id="txtTemp" styles="color:blue;width:100%"  onenterkey ="OnSearch()"  /></td>
		            <td colspan=2 style="border:0" align="right"><gw:imgBtn id="ibtnSearch"  alt="Search"  img="search" text="Search"  onclick="OnSearch()" /></td>
		            
				</tr >
				<tr  style="border:0;height:5%" >
					<td colspan=1 style="border:0" align="right"><gw:checkbox id="chkTo" value="F" onclick="OnCheck(1)" ></gw:checkbox ></td>
					<td colspan=2 style="border:0" align="left" style="white-space:nowrap">To:<gw:label id="idlbTo" text="0" styles="width:100%"></gw:label></td>
				    <td colspan=1 style="border:0" align="right"><gw:checkbox id="chkCC" value="F" onclick="OnCheck(2)" ></gw:checkbox ></td>
				    <td colspan=2 align="left" style="white-space:nowrap">CC:<gw:label id="idlbCC" text="0" styles="width:100%"></gw:label></td>
				    
				    <td colspan=4></td>
				    
				</tr>
				
		        <tr  style="border:1;height:90%">
		            <td colspan=11 style="width:100%;height:100%">
		               <table border=1 width=100% style="height:100%" cellspacing=0 border=0>
		                    <tr>
		                        <td>
		                            <gw:grid   
			                        id="grdEmployee"  
			                        header="_PK|To|CC|Full Name|Emp ID|_Join DT|E-Mail|Sending Status|_Full_fName"
			                        format="0|3|3|0|0|4|0|0|0"  
			                        aligns="0|0|0|0|0|0|0|0|0"
			                        defaults="||||||||"  
			                       editcol="0|1|1|0|0|0|0|0|0"  
			                        widths="0|500|500|2000|1200|1200|1200|1500|0"  
			                        styles="width:100%; height:100%"   
			                        sorting="T"   
			                        onafteredit ="OnClickRow()"
			                        param="0,1,2,3,4,5,6,7"   />
		                        </td>
		                    </tr>
		               </table>
		            </td>
		        </tr>
	        </table>
    </td>
    </tr>
  </table> 
  <table name="History" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
   <tr style="width:100%;height:5%;" valign="center">
     <td style="border:0;width:8%" align=right> Send Date </td>
   <td style="border:0 ;width:5%" ><gw:datebox id="dtSend_from" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				    <td style="border:0;width:2%" > ~ </td>
				    <td style="border:0;width:5%" ><gw:datebox id="dtSend_to" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
   <td style="border:0;width:8%" align=right>Mail title </td>
   <td style="border:0;width:10%" >
   <gw:list  id="lstTitle1" value="ALL" maxlen = "10" styles='width:100%' onchange="" > 
                            <data>
                                LIST|1|Pay Slip|2|Other|ALL|Select All
                            </data>
                            </gw:list></td>
   <td style="border:0;width:10%" align=right>Sending Status </td>
   <td style="border:0;width:10%" >
   <gw:list  id="lstSendingStatus" value="ALL" maxlen = "10" styles='width:100%' onchange="" > 
                            <data>
                                LIST|0|Error|1|Success|ALL|Select ALL
                            </data>
                            </gw:list></td>
   <td style="border:0 ;width:8%" align="right" >Search by</td>
		            <td  style="border:0;width:10%">									
			            <gw:list  id="chkTemp1" value="2" styles="color:blue;width:100%" onchange=""> 
					            <data> LIST|1|Sender Name|2|Sender ID|6|Sender Email|3|Receiver Name|4|Receiver ID|7|Receiver Email|5|Subject</data> 
			            </gw:list>
		            </td>
		            <td style="border:0;width:10%"><gw:textbox id="txtTemp1" styles="color:blue;width:100%"  onenterkey ="OnSearch1()"  /></td>
   <td style="border:0;width:2%" align="right" ><gw:imgBtn id="ibtnSearch1"  alt="Search"  img="search" text="Search"  onclick="OnSearch1()" /></td>
 </tr>
 
   <tr  style="border:1;height:90%">
		            <td colspan=12 style="width:100%;height:100%">
		               <table border=1 width=100% style="height:100%" cellspacing=0 border=0>
		                    <tr>
		                        <td>
		                            <gw:grid   
			                        id="grdSendMail"  
			                        header="Sender|Send Date|Receiver Name|Option|Status|Subject|Content"
			                        format="0|0|0|0|0|0|0"  
			                        aligns="0|0|0|0|0|0|0"  
			                        defaults="||||||"  
			                       editcol="0|0|0|0|0|0|0"  
			                        widths="4500|2500|4500|1500|1500|3000|35000|4000"  
			                        styles="width:100%; height:100%"   
			                        sorting="T"   
			                        onafteredit =""
			                        param="0,1,2,3,4,5,6,7"   />
		                        </td>
		                    </tr>
		                    </table>
		                    </td>
 				    
  </tr>
  </table>
</gw:tab>   
    <!------------------------------------------->
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="seq" styles="display:none"/>
    <gw:textbox id="txtCC" styles="display:none"/>
    <gw:textbox id="txtTo" styles="display:none"/>
    <gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtEmpPk" styles="display:none"/>
    <gw:textbox id="txtMailOption" styles="display:none"/>
    <gw:textbox id="txtlstPk" styles="display:none"/>
    <gw:textbox id="txtlstPkCC" styles="display:none"/>
    
</body>
</html>
