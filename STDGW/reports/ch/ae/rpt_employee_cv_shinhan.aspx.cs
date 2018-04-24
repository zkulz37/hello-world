using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class rpt_employee_cv_shinhan : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string emp_pk,p_sal_security;
		emp_pk = Request["emp_pk"].ToString();
		
		
		
        string TemplateFile = "rpt_employee_cv_shinhan.xls";
		
        string TempFile = "../../../system/temp/rpt_employee_cv_shinhan_" + DateTime.Now.ToString("hhmmss") + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
		IPageBreaks pbs = exSheet.HPageBreaks;
		IRange usedrange = exSheet.UsedRange;
		pbs.Reset();
		
		string SQL
		= "SELECT E.PK AS COL0,E.FULL_NAME AS COL1,(CASE WHEN LENGTH(E.BIRTH_DT) = 8 THEN   " + 
        "   TO_CHAR(TO_DATE(E.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')  " +
        "   WHEN LENGTH(E.BIRTH_DT) = 6 THEN  " +
        "   TO_CHAR(TO_DATE(E.BIRTH_DT,'YYYYMM'),'DD/MM/YYYY')  " +
        "   ELSE E.BIRTH_DT END ) AS COL2,  " +
        "   DECODE(E.SEX,'F','Female','M','Male',E.SEX) as COL3,  " +
        "   E.ID_CARD_NO AS COL4,                      " +
        "   'A' AS COL5,  " +
        "   DECODE(E.MARRIED_YN,'Y','Maried','N','Single','') AS COL6,  " +
        "   DECODE(LENGTH(E.ISSUE_DT),8,TO_CHAR(TO_DATE(E.ISSUE_DT,'YYYYMMDD'),'DD/MM/YYYY'),6,TO_CHAR(TO_DATE(E.ISSUE_DT,'YYYYMM'),'MM/YYYY'),E.BIRTH_DT) AS COL7,  " +
        "   nvl(E.HEIGHT,0)/100 || ' m' AS COL8,  " +
        "   (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID ='HR0001' AND V.CODE = E.CONTRACT_TYPE) AS COL9,  " +
        "   nvl(E.WEIGHT,0) || ' kg' AS COL10,  " +
        "   E.PRESENT_ADDR  AS COL11,  " +
        "   E.TEL AS COL12,  " +
        "   E.PERMANENT_ADDR  AS COL13,  " +
        "   E.HOME_PHONE AS COL14,  " +
        "   (SELECT c.data FROM tc_fsbinary c WHERE c.del_if = 0 AND c.pk = E.PHOTO_PK) as COL15,  " +
		"	to_char(to_date(E.JOIN_DT,'YYYYMMDD'),'DD Mon YYYY') as COL16, "+
		"	(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID = 'HR0008' AND V.CODE = E.POS_TYPE) AS COL17, "+
		"	(SELECT O2.ORG_NM FROM TCO_ORG2 O2 WHERE O2.DEL_IF =0 AND O2.PK = E.TCO_ORG_PK2 ) AS COL18, "+
		"	(select MAX(G.ORG_NM) from tco_org g  where  g.del_if = 0 and G.ORG_TYPE='06'  start with g.pk = E.TCO_ORG_PK  connect by prior g.pk = g.p_pk ) as COL19 "+
		" 	FROM THR_EMPLOYEE E  "+
		"	WHERE E.DEL_IF = 0 " +
        "	AND E.PK  in(" + emp_pk + ") " ;
		
        // Response.Write(emp_pk);
		// Response.End();
		
		DataTable dt_emp = ESysLib.TableReadOpen(SQL);
	   		
		// info Shinhan Bank		

        int i,irow, icol_emp;
        irow = dt_emp.Rows.Count;
		icol_emp = dt_emp.Columns.Count;
		
		int loop = 47;        
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }

       for (i=1 ;i<irow ;i++)
	   {
		   
			exSheet.Range[1, 1, loop, 38].Copy(exSheet.Range[(i) * loop, 1, (i+1) * loop, 38], XlPasteType.xlPasteAll);			 
			pbs.Add(usedrange.Rows[loop * (i) ]);		 
			for (int j = 1 ;j< 38;j++)
				{
					exSheet.Range[(loop * i) + j, 1].RowHeight = exSheet.Range[j, 1].RowHeight;	
				}   		 
	   }
	   
	   int temp_edu = 0 ;
	   int temp_career = 0  ;
	   int temp_eva = 0 ;
	   int temp_promo = 0 ;
	   int temp_move = 0 ;
	   int temp_discip = 0 ;
	   int temp_rela = 0 ;
        
		
		for( i= 0 ;i < irow;i++)
		{
				int row_dis_rel =0 ;
			
				DataTable dt_edu;	
				DataTable dt_career;
				DataTable dt_promotion;
				DataTable dt_movement;
				DataTable dt_discip;
				DataTable dt_family;
				
					if (dt_emp.Rows[i]["COL15"].ToString() != "")
					{
						byte[] MyData = new byte[0];
						MyData = (byte[])dt_emp.Rows[i]["COL15"];
						MemoryStream stream = new MemoryStream(MyData);

						Bitmap b = new Bitmap(stream);
						exSheet.Cells[1 + ((loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela), 32].Select();
						exSheet.Shapes.AddPicture(ResizeImage(b, 108, 147));
					}
					{
					exSheet.Cells["H" + (6 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL1"].ToString();
					exSheet.Cells["H" + (7 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL2"].ToString();
					exSheet.Cells["H" + (8 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL3"].ToString();
					exSheet.Cells["H" + (9 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL6"].ToString();
					exSheet.Cells["H" + (10 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL9"].ToString();
					exSheet.Cells["H" + (11 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL11"].ToString();
					exSheet.Cells["H" + (12 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL13"].ToString();					
					exSheet.Cells["T" + (8 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL4"].ToString();
					exSheet.Cells["T" + (9 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL7"].ToString();					
					exSheet.Cells["AD" + (9 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL8"].ToString();
					exSheet.Cells["AD" + (10 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL10"].ToString();					
					exSheet.Cells["AF" + (11 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL12"].ToString();
					exSheet.Cells["AF" + (12 + (loop * i) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela)].Value =	dt_emp.Rows[i]["COL14"].ToString();								
					}
				// edu
					string SQL_EDU
					=  "SELECT A.THR_EMP_PK AS COL0, " + 
					"       A.E_NAME AS COL1 , " +
					"       A.MAJOR AS COL2, " +
					"       A.START_DT AS COL3, " +	
					"		(select CODE_NM from vhr_hr_code where id='HR0011' and code = a.DEGREE_TYPE) as LEVEL_APP,  "+
					"		a.MAJOR, "+				
					"		a.END_DT 	"+					
					" FROM  THR_EMP_EDU A 	"+
					" WHERE A.DEL_IF = 0  "+
					" AND A.THR_EMP_PK in (" + dt_emp.Rows[i]["COL0"].ToString() + ")	";
											
					//Response.Write(SQL_EDU);
					//Response.End();
					
					dt_edu = ESysLib.TableReadOpen(SQL_EDU);
					 
					for (int j =0 ;j< dt_edu.Rows.Count-1;j++)
					{
						exSheet.Range[17+(i*loop)+ temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela+ j, 1].Rows.EntireRow.Insert();						
					}
					for(int j =0 ;j< dt_edu.Rows.Count;j++)
					{			
						exSheet.Cells["B" +( 16+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_edu.Rows[j]["LEVEL_APP"].ToString();
						exSheet.Cells["J" +( 16+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_edu.Rows[j]["COL1"].ToString();
						exSheet.Cells["W" +( 16+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_edu.Rows[j]["major"].ToString();
						exSheet.Cells["AG" +( 16+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_edu.Rows[j]["end_dt"].ToString();
						temp_edu+=1;	
					}		
						if (temp_edu>=0 && dt_edu.Rows.Count >0 )	
						{
							temp_edu=temp_edu-1;
						}							
							
				// career
					string SQL_CAREER
					= "SELECT  A.THR_EMPLOYEE_PK AS COL0, " + 
					"A.START_DT || ' ~ ' || A.END_DT AS COL1,A.COM_NM,A.POSITION " +
					"        FROM THR_EXPERIENCE A  " +
					"        WHERE A.DEL_IF = 0  " +
					"        AND A.THR_EMPLOYEE_PK  =(" + dt_emp.Rows[i]["COL0"].ToString() + ")  " ;
					
					dt_career = ESysLib.TableReadOpen(SQL_CAREER);
					
					for (int j =0 ;j< dt_career.Rows.Count-1;j++)
					{
						exSheet.Range[21+(i*loop) +temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela+ j, 1].Rows.EntireRow.Insert();						
					}
					for(int j =0 ;j< dt_career.Rows.Count;j++)
					{										
						exSheet.Cells["B" +( 20+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_career.Rows[j]["COL1"].ToString();						
						exSheet.Cells["H" +( 20+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_career.Rows[j]["COM_NM"].ToString();						
						exSheet.Cells["AA" +( 20+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_career.Rows[j]["POSITION"].ToString();						
						temp_career= temp_career+1;		
					}			
					if(temp_career > 0 && dt_career.Rows.Count >0)		
					{
						temp_career = temp_career - 1;
					}						
					
					
				//  Employee Status
				
					exSheet.Cells["I" +(23+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_emp.Rows[i]["COL16"].ToString();
					exSheet.Cells["AA" +(23+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_emp.Rows[i]["COL18"].ToString();
					exSheet.Cells["I" +(24+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_emp.Rows[i]["COL17"].ToString();					
					exSheet.Cells["AA" +(24+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_emp.Rows[i]["COL19"].ToString();
					//exSheet.Cells["AC" +(24+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value =temp_career;
				// Promotion
					string SQL_PROMOTION
					= "SELECT A.THR_EMPLOYEE_PK AS COL0, " + 
					"       TO_CHAR (TO_DATE (A.APPOINT_DATE, 'YYYYMMDD'), 'DD Mon YYYY') AS COL1, " +
					"       (SELECT V.CODE_NM " +
					"          FROM VHR_HR_CODE V " +
					"         WHERE V.ID = 'HR0008' AND V.CODE = A.TO_POS_TYPE) as COL2, " +				
					"       '' AS COL3 " +
					"  FROM thr_appointment_detail A " +
					" WHERE     A.DEL_IF = 0 " +
					"       AND A.THR_EMPLOYEE_PK in(" + dt_emp.Rows[i]["COL0"].ToString() + ") " +					
					"		AND NVL(A.APP_TYPE,'10') in ('0','2')  ";
					
					dt_promotion = ESysLib.TableReadOpen(SQL_PROMOTION);
					
					for (int j =1 ;j< dt_promotion.Rows.Count;j++)
					{
						exSheet.Range[31+(i*loop)+1+ temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela+ j, 1].Rows.EntireRow.Insert();						
					}
					for(int j =0 ;j< dt_promotion.Rows.Count;j++)
					{										
						exSheet.Cells["B" +( 31+(i*loop)+1 + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_promotion.Rows[j]["COL1"].ToString();
						exSheet.Cells["I" +( 31+(i*loop)+1 + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_promotion.Rows[j]["COL2"].ToString();
						exSheet.Cells["P" +( 31+(i*loop)+1 + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = "";
						temp_promo= temp_promo +1;					
					}	
					if(temp_promo >0 && dt_promotion.Rows.Count > 0 )
					{
						temp_promo= temp_promo -1;
					}
					
				// Movement		
					string SQL_MOVEMENT
					= "SELECT A.THR_EMPLOYEE_PK AS COL0, " + 
					"       TO_CHAR (TO_DATE (A.APPOINT_DATE, 'YYYYMMDD'), 'DD Mon YYYY') AS COL1, " +
					"       (SELECT o.org_nm " +
					"          FROM tco_org o " +
					"         WHERE o.del_if =0 and o.pk = A.FROM_ORG_PK) " +
					"          AS COL2, " +
					"       (SELECT o.org_nm " +
					"          FROM tco_org o " +
					"         WHERE o.del_if =0 and o.pk = A.TO_ORG_PK) " +
					"          AS COL3, " +
					"       (SELECT V.CODE_NM " +
					"          FROM VHR_HR_CODE V " +
					"         WHERE V.ID = 'HR0008' AND V.CODE = A.TO_POS_TYPE) " +
					"          AS COL4, " +
					"          TO_CHAR(TO_DATE(A.APPOINT_DATE,'YYYYMMDD'),'DD/MM/YYYY') AS COL5                    " +
					"  FROM thr_appointment_detail A " +
					" WHERE     A.DEL_IF = 0 " +
					"       AND A.THR_EMPLOYEE_PK in(" + dt_emp.Rows[i]["COL0"].ToString() + ") " +					
					"		AND NVL(A.APP_TYPE,'10') in ('1','2') "
					;
					
					// Response.Write(SQL_MOVEMENT);
					// Response.End;
					
					dt_movement = ESysLib.TableReadOpen(SQL_MOVEMENT);
					
					for (int j =0 ;j< dt_movement.Rows.Count-1;j++)
					{
						exSheet.Range[37+(i*loop)+ temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela+ j, 1].Rows.EntireRow.Insert();						
					}
					for(int j =0 ;j< dt_movement.Rows.Count;j++)
					{						
						exSheet.Cells["B" +( 36+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_movement.Rows[j]["COL1"].ToString();
						exSheet.Cells["F" +( 36+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_movement.Rows[j]["COL2"].ToString();
						exSheet.Cells["K" +( 36+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_movement.Rows[j]["COL3"].ToString();
						exSheet.Cells["P" +( 36+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_movement.Rows[j]["COL4"].ToString();
						exSheet.Cells["T" +( 36+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_movement.Rows[j]["COL5"].ToString();
						exSheet.Cells["X" +( 36+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = "";
						temp_move+=1;
					}
					if (temp_move > 0 && dt_movement.Rows.Count > 0)
					temp_move=temp_move-1;
				// Disciplinary
				string SQL_DISCIP
					= "select A.DIS_DT as COL0,(select v.code_nm from vhr_hr_code v where v.code = A.DIS_LEVEL and v.id ='HR0025')  as COL1 " + 
					",A.REASON  as COL2,(CASE WHEN LENGTH(A.START_DT) = 8 THEN TO_CHAR(TO_DATE(A.START_DT,'YYYYMMDD'),'DD/MM/YYYY') ELSE A.START_DT END )    as COL3, "+
					"(CASE WHEN LENGTH(A.END_DT) = 8 THEN TO_CHAR(TO_DATE(A.END_DT,'YYYYMMDD'),'DD/MM/YYYY') ELSE A.END_DT END )   as COL4 " +
					"from thr_discipline a " +
					"where a.del_if =0  " +
					"AND A.THR_EMP_PK in(" + dt_emp.Rows[i]["COL0"].ToString() + ") " 
				;
				dt_discip = ESysLib.TableReadOpen(SQL_DISCIP);				
				row_dis_rel  = dt_discip.Rows.Count;
				
				// RELATION IN Shinhan
				string SQL_FAMILY_SHB
					= "select ROWNUM AS COL0,A.THR_EMPLOYEE_PK AS COL1, " + 
					"(select v.code_nm from vhr_hr_code v where v.id ='HR0024' and v.code = a.relation)  AS COL2, " +
					"A.FULL_NAME AS COL3, " +
					"A.JOB AS COL4, " +
					"A.COMPANY_NAME AS COL5 " +
					"from thr_family a " +
					"where a.del_if =0  " +
					"and nvl(A.WK_AT_SHB,'N')='Y' "+
					"AND A.THR_EMPLOYEE_PK in(" + dt_emp.Rows[i]["COL0"].ToString() + ") " ;
								
				DataTable dt_rela_shb = ESysLib.TableReadOpen(SQL_FAMILY_SHB);
				
					if (dt_discip.Rows.Count < dt_rela_shb.Rows.Count)
					{
						row_dis_rel = dt_rela_shb.Rows.Count;
					}
				
					for (int j =0 ;j< row_dis_rel-1;j++)
					{
						exSheet.Range[42+(i*loop)+ temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela+ j, 1].Rows.EntireRow.Insert();						
					}
					for(int j =0 ;j< row_dis_rel ;j++)						
					{		
						if (j < dt_rela_shb.Rows.Count )
						{
							exSheet.Cells["T" +( 41+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move  + temp_rela + j )].Value = dt_rela_shb.Rows[j]["COL3"].ToString();						
							exSheet.Cells["Y" +( 41+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move  + temp_rela + j)].Value = dt_rela_shb.Rows[j]["COL2"].ToString();
							exSheet.Cells["AD" +( 41+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move  + temp_rela + j)].Value = "";							
							exSheet.Cells["AH" +( 41+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move  + temp_rela + j)].Value = "";							
						}
						if (j < dt_discip.Rows.Count )
						{
							exSheet.Cells["B" +( 41+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_discip.Rows[j]["COL0"].ToString();						
							exSheet.Cells["F" +( 41+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_discip.Rows[j]["COL1"].ToString();
							exSheet.Cells["H" +( 41+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_discip.Rows[j]["COL2"].ToString();
							exSheet.Cells["P" +( 41+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_discip.Rows[j]["COL3"].ToString();
							exSheet.Cells["R" +( 41+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_discip.Rows[j]["COL4"].ToString();
							temp_discip+=1;
						}
						
					}
					if (temp_discip < dt_rela_shb.Rows.Count)
					{
						temp_discip = dt_rela_shb.Rows.Count;
					}
					if((temp_discip > 0 && dt_discip.Rows.Count > 0) || (temp_discip > 0 && dt_rela_shb.Rows.Count > 0  ))
					temp_discip = temp_discip-1;
				
				//family
				string SQL_FAMILY
					= "select ROWNUM AS STT,A.THR_EMPLOYEE_PK, " + 
					"(select v.code_nm from vhr_hr_code v where v.id ='HR0024' and v.code = a.relation) as relation, " +
					"A.FULL_NAME, " +
					"A.JOB, " +
					"A.COMPANY_NAME " +
					"from thr_family a " +
					"where a.del_if =0  " +
					"AND A.THR_EMPLOYEE_PK in(" + dt_emp.Rows[i]["COL0"].ToString() + ") " ;
				
				dt_family = ESysLib.TableReadOpen(SQL_FAMILY);
				
				for (int j =0 ;j< dt_family.Rows.Count-1;j++)
					{
						exSheet.Range[46+(i*loop)+ temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela+ j, 1].Rows.EntireRow.Insert();						
					}
				for(int j =0 ;j< dt_family.Rows.Count;j++)
				{						
					exSheet.Cells["B" +( 45+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_family.Rows[j]["STT"].ToString();
					exSheet.Cells["C" +( 45+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_family.Rows[j]["relation"].ToString();
					exSheet.Cells["G" +( 45+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_family.Rows[j]["FULL_NAME"].ToString();
					exSheet.Cells["T" +( 45+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_family.Rows[j]["JOB"].ToString();
					exSheet.Cells["AB" +( 45+(i*loop) + temp_edu + temp_career + temp_eva + temp_promo + temp_move + temp_discip + temp_rela )].Value = dt_family.Rows[j]["COMPANY_NAME"].ToString();
					temp_rela+=1;
				}
				if(temp_rela>0 && dt_family.Rows.Count > 0 )
				{
					temp_rela = temp_rela-1;	
				}
				
						
			//pbs.Add(usedrange.Rows[30 * i+1 ]);			
		}
		
		// end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }

        // hide row firts 

        //range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;

        exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        //string pdfFilePath = TempFile.Replace(".xls", ".pdf");

        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        //System.IO.FileInfo file = new System.IO.FileInfo(pdfFilePath);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Response.ContentType = "application/pdf";
        //Send file string to client 
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();
    }
	public Bitmap ResizeImage(Bitmap d, int w, int h)
    {
        Bitmap q = new Bitmap(w, h);
        float f, g;
        f = (float)w / (float)d.Width;
        g = (float)h / (float)d.Height;
        for (int i = 0; i < w; i++)
        {
            for (int j = 0; j < h; j++)
            {
                Color c;
                c = d.GetPixel((int)(i / f), (int)(j / g));
                q.SetPixel(i, j, c);
            }
        }
        return q;
    } 
}