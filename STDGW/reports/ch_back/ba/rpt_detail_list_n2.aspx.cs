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

public partial class rpt_detail_list_n2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string TemplateFile = "rpt_detail_list_n2.xls";
        string TempFile = "../../../system/temp/rpt_detail_list_n2_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

         //Create a new workbook
		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

		//Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];
		IRange range;		
		MemoryStream stream;
		Bitmap b;

        string p_tco_dept_pk, p_thr_group_pk, p_status, p_emp_id, p_work_mon, p_from_dt, p_to_dt, p_work_shift, p_salary_period, p_nation, p_search_by, p_search_temp, p_reg;

        p_tco_dept_pk = Request["p_tco_org_pk"].ToString();
        p_thr_group_pk = Request["p_wg"].ToString();
        p_search_by = Request["p_search_by"].ToString();
        p_search_temp = Request["p_search_temp"].ToString();

        p_to_dt = Request["p_to_date"].ToString();
        p_from_dt = Request["p_from_date"].ToString();

        p_work_shift = Request["p_work_shift"].ToString();


        p_nation = Request["p_nation"].ToString();
        p_reg = Request["p_reg"].ToString();

       

        string SQL
     = "select c.emp_id||'-'||C.FULL_NAME C0,E.ORG_NM C1,D.ORG_NM C2  " +
         "   ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE=C.POS_TYPE) C3  " +
         ",to_char(to_date(a.work_dt,'yyyymmdd'),'dd/mm/yyyy') C4  " +
         ",decode(a.day_type,1,'CN',a.day_type) C5,b.time_in C6,b.time_out C7,s.shift C8,round(nvl(b.work_time,0)-nvl(B.MINUS_WT,0),2) C9,0 C10,round(nvl(ot.ot,0),2) C11  " +
         ",round(nvl(ot.st,0),2) C12,round(nvl(ot.oht,0),2) C13,round(nvl(ot.nt_30,0),2) C14,round(nvl(ot.nt_45,0),2) C15,round(nvl(ot.nt_60,0),2) C16  " +
         ",(case when (HR_F_LATELY_EARLY(a.WORK_DT,s.START_TIME,b.DATE_IN,b.TIME_IN,'IN',b.thr_emp_pk)) >=0 then 0   " +
         "                       else   " +
         "                           ABS((HR_F_LATELY_EARLY(a.WORK_DT,s.START_TIME,b.DATE_IN,b.TIME_IN,'IN',b.thr_emp_pk)))   " +
         "                     END ) C17   " +
         "           ,(case when (HR_F_LATELY_EARLY(b.DATE_OUT,b.TIME_OUT,DECODE(s.DURING_DAY,1,b.WORK_DT,TO_CHAR(TO_DATE(b.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),s.END_TIME,'OUT',b.thr_emp_pk)) >=0 then 0   " +
         "                       else   " +
         "                           abs((HR_F_LATELY_EARLY(b.DATE_OUT,b.TIME_OUT,DECODE(s.DURING_DAY,1,b.WORK_DT,TO_CHAR(TO_DATE(b.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),s.END_TIME,'OUT',b.thr_emp_pk)))   " +
         "                     end) C18 ,nvl(B.MINUS_WT,0)+nvl(B.MINUS_OT,0) C19  " +
         " ,(CASE WHEN h.absence_type IS NOT NULL THEN  (select V.CHAR_1 from vhr_hr_code v where v.id='HR0003' and v.code= h.absence_type) " +
         "             ELSE  A.NOTE_ATT END) C20,h.absence_type C21  " +
         ",(CASE WHEN NVL(h.absence_type,'0')<>'0' THEN DECODE(NVL(H.COMPANY_PAY_YN,'N'),'N',0,round(nvl(h.absence_time,0)/8,2)) ELSE 0 END) C22,(CASE WHEN NVL(A.HOL_TYPE,' ')='HOL' THEN HR_CHECK_HOL_NB(a.thr_emp_pk,a.work_dt) ELSE 0 END) C23 " +
         "               ,(CASE WHEN NVL(h.absence_type,'0')<>'0' THEN DECODE(NVL(H.COMPANY_PAY_YN,'N'),'N',round(nvl(h.absence_time,0)/8,2),0) ELSE 0 END) C24 " +
        "from thr_employee c,thr_wg_sch_detail a,thr_time_machine b,tco_org d,tco_org e,thr_work_shift s,thr_absence h " +
        ",(select e.pk thr_emp_pk,m.work_dt,sum((case when t.hol_type is null and t.ot_type='OT' then nvl(t.ot_time,0)   else 0 end)  " + 
        "                            + (case when m.hol_type is null then (nvl(m.ot_plus,0)-nvl(M.MINUS_OT,0) ) else 0 end)) ot " +
        "                    ,sum((case when nvl(t.hol_type,'NOR')='SUN' and t.ot_type in('OT','HT') then nvl(t.ot_time,0) " +
        "                              when nvl(t.hol_type,'NOR')='HOL' and t.ot_type ='HT' THEN nvl(t.ot_time,0) " +
        "                              ELSE 0 END) " +
        "                              +(case when nvl(T.hol_type,'NOR')='SUN' then (nvl(m.ot_plus,0) -nvl(M.MINUS_OT,0)-nvl(M.MINUS_WT,0)) " +
        "                              when nvl(T.hol_type,'NOR')='HOL' and t.ot_type ='HT' THEN -nvl(M.MINUS_WT,0) " +
        "                              ELSE 0 END)) ST    " +
        "                    ,sum((case when nvl(t.hol_type,'NOR')='HOL' and t.ot_type in('OT') then nvl(t.ot_time,0) ELSE 0 END) " +
        "                        +(case when nvl(t.hol_type,'NOR')='HOL' and t.ot_type in('OT') then nvl(m.ot_plus,0)-nvl(M.MINUS_OT,0) ELSE 0 END) " +
        "                        ) OHT " +
        "                    ,sum(case when t.hol_type is null and t.ot_type in('NT') then nvl(t.ot_time,0) else 0 end) nt_30   " +
        "                     ,sum(case when t.hol_type is null and t.ot_type in('NT2') then nvl(t.ot_time,0) else 0 end) nt_45   " +
        "                     ,sum(case when t.hol_type is not null and t.ot_type in('NT') then nvl(t.ot_time,0) else 0 end) nt_60 "+
        " from thr_extra_time t,thr_employee e,thr_time_machine m " +
        " where t.del_if(+)=0 and e.del_if=0 and m.del_if=0 and e.pk=m.thr_emp_pk and m.thr_emp_pk=t.thr_emp_pk(+) and t.work_dt(+)=m.work_dt " +
        "  and m.work_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
        " and (e.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        " and decode('" + p_thr_group_pk + "','ALL','ALL',e.thr_wg_pk)='" + p_thr_group_pk + "' " +
        "     AND (   DECODE ('" + p_search_by + "', " +
        "                     '1', UPPER (e.emp_id), " +
        "                     '2', e.id_num, " +
        "                     '3', UPPER (e.full_name) " +
        "                    ) LIKE '%' || UPPER ('" + p_search_temp + "') " +
        "          OR '" + p_search_temp + "' IS NULL " +
        "         ) " +
        "   AND ('" + p_reg + "'='ALL' OR e.PK IN(SELECT R.THR_EMP_PK " +
        "                                         FROM THR_REGULATION R  " +
        "                                         WHERE R.DEL_IF=0 AND R.THR_EMP_PK=e.PK " +
        "                                            AND m.WORK_DT>=R.START_DT AND NVL(R.END_DT,m.WORK_DT)>=m.WORK_DT) " +
        "        ) " +
        " and decode('" + p_work_shift + "','ALL','ALL',m.thr_ws_pk)='" + p_work_shift + "' " +
        " and decode('" + p_nation + "','ALL','ALL',nvl(e.nation,'01'))='" + p_nation + "' " +
        "  group by e.pk,m.work_dt " +
        ") ot " +
        "where c.del_if=0 and a.del_if=0 and b.del_if(+)=0 and d.del_if=0 and e.del_if=0 and s.del_if=0 and h.del_if(+)=0 and a.thr_ws_pk=s.pk " +
        "and c.pk=a.thr_emp_pk and a.thr_emp_pk=b.thr_emp_pk(+) and a.work_dt=b.work_dt(+) " +
        "and c.tco_org_pk=d.pk and d.p_pk=e.pk and a.thr_emp_pk=h.thr_emp_pk(+) and a.work_dt=h.absence_dt(+) " +
        "and a.work_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
        "and a.thr_emp_pk=ot.thr_emp_pk(+) " +
        "and a.work_dt=ot.work_dt(+) and c.join_dt<=a.work_dt and nvl(c.left_dt,'99999999')>=a.work_dt" +
        " and (c.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        " and decode('" + p_thr_group_pk + "','ALL','ALL',c.thr_wg_pk)='" + p_thr_group_pk + "' " +
        "     AND (   DECODE ('" + p_search_by + "', " +
        "                     '1', UPPER (c.emp_id), " +
        "                     '2', c.id_num, " +
        "                     '3', UPPER (c.full_name) " +
        "                    ) LIKE '%' || UPPER ('" + p_search_temp + "') " +
        "          OR '" + p_search_temp + "' IS NULL " +
        "         ) " +
        "   AND ('" + p_reg + "'='ALL' OR c.PK IN(SELECT R.THR_EMP_PK " +
        "                                         FROM THR_REGULATION R  " +
        "                                         WHERE R.DEL_IF=0 AND R.THR_EMP_PK=c.PK " +
        "                                            AND a.WORK_DT>=R.START_DT AND NVL(R.END_DT,a.WORK_DT)>=a.WORK_DT) " +
        "        ) " +
        " and decode('" + p_work_shift + "','ALL','ALL',a.thr_ws_pk)='" + p_work_shift + "' " +
        " and decode('" + p_nation + "','ALL','ALL',nvl(c.nation,'01'))='" + p_nation + "' " +
        "order by  c.emp_id,a.work_dt ";
				
		//Response.Write(SQL);
		//Response.End();
        DataTable myDT = ESysLib.TableReadOpen(SQL);



        int l_row = myDT.Rows.Count;
        int l_col = myDT.Columns.Count;
        int l_fix_row1 = 11;
        int l_fix_row2 = 9;
        int n_dept = 0;
        int stt = 0;
        int current_row = 11;
        int row_for_1 = 0;
        int flag = 0;
        int so_nguoi = 0;


        double[] grant_total = new double[l_col];
        int l_pos = 12;

        for (int k = 0; k < l_col; k++)
        {
            grant_total[k] = 0;
        }

        for (int i = 0; i < l_row - 1; i++)
        {
            if (flag == 0)
                row_for_1 += 1;
            if (myDT.Rows[i]["C0"].ToString() != myDT.Rows[i + 1]["C0"].ToString())
            {
                n_dept += l_fix_row2 + l_fix_row1;
                so_nguoi += 1;
                flag = 1;
            }
        }

        for (int i = 0; i < l_row - 1 + n_dept; i++)
        {

            exSheet.Range[l_pos + i + 1, l_col].Rows.EntireRow.Insert();//insert dong moi 

        }

        string p_from = p_from_dt.Substring(6, 2) + "/" + p_from_dt.Substring(4, 2) + p_from_dt.Substring(0, 4);
        string p_to = p_to_dt.Substring(6, 2) + "/" + p_to_dt.Substring(4, 2) + p_to_dt.Substring(0, 4);

        exSheet.Cells[3, 1].Value = string.Format("TỪ {0} TỚI {1}", p_from, p_to);
        exSheet.Cells[5, 1].Value = "MSNV VÀ TÊN  : " + myDT.Rows[0]["C0"].ToString();
        exSheet.Cells[6, 1].Value = "PHÒNG BAN  : " + myDT.Rows[0]["C1"].ToString();
        exSheet.Cells[7, 1].Value = "BỘ PHẬN  : " + myDT.Rows[0]["C2"].ToString();
        exSheet.Cells[8, 1].Value = "VỊ TRÍ  : " + myDT.Rows[0]["C3"].ToString();

        for (int i = 0; i < l_row; i++)
        {
            stt += 1;
            current_row += 1;
            exSheet.Cells[current_row, 1].Value = stt;
            //exSheet.Cells[current_row, 19].Value = current_row - l_fix_row2 + 2;
            //exSheet.Cells[current_row, 20].Value = ((so_nguoi + 1) * (l_fix_row1 + l_fix_row2 + row_for_1));

            for (int j = 1; j <= l_col - 4; j++)
            {
                if ((j >= 6 && j <= 16) || (j >= 19))//xac dinh cac cot kieu so
                {
                    if (j <= l_col - 7)
                        exSheet.Cells[current_row, j + 1].Value = double.Parse(myDT.Rows[i][j + 3].ToString());

                    grant_total[j] += double.Parse(myDT.Rows[i][j + 3].ToString());
                }
                else
                {
                    if (j <= l_col - 8)
                        exSheet.Cells[current_row, j + 1].Value = myDT.Rows[i][j + 3].ToString();
                }


            }



            if (i < l_row - 1) //chua phai la dong cuoi cung
            {
                if (myDT.Rows[i]["C0"].ToString() != myDT.Rows[i + 1]["C0"].ToString())//sang nguoi moi
                {

                    current_row += 1;//dong tong gio lam viec 
                    exSheet.Range["A" + current_row + ":" + "F" + current_row].Rows.Merge();
                    exSheet.Cells[current_row, 1].Value = "Tổng số giờ làm việc: ";
                    exSheet.Cells[current_row, 1].HorizontalAlignment = XlHAlign.xlHAlignLeft;
                    exSheet.Range["A" + current_row + ":" + "R" + current_row].Font.Bold = true;

                    //dong tong so ngay lam viec
                    for (int j = 6; j <= 16; j++)
                    {
                        exSheet.Cells[current_row, j + 1].Value = grant_total[j];
                    }

                    current_row += 1;//dong tong ngay cong
                    exSheet.Range["A" + current_row + ":" + "F" + current_row].Rows.Merge();
                    exSheet.Cells[current_row, 1].Value = "Tổng số ngày công: ";
                    exSheet.Cells[current_row, 1].HorizontalAlignment = XlHAlign.xlHAlignLeft;
                    exSheet.Cells[current_row, 7].Value = Math.Round(grant_total[6] / 8, 2);
                    exSheet.Cells[current_row, 7].Font.Bold = true;
                    exSheet.Range["A" + current_row + ":" + "G" + current_row].Font.Size = 10;

                    current_row += 2;//dong ngay le
                    exSheet.Range["A" + current_row + ":" + "F" + current_row].Rows.Merge();
                    exSheet.Cells[current_row, 1].Value = "Số ngày nghỉ lễ: ";
                    exSheet.Cells[current_row, 1].HorizontalAlignment = XlHAlign.xlHAlignLeft;
                    exSheet.Cells[current_row, 7].Value = grant_total[20]; //ngay le
                    exSheet.Cells[current_row, 7].Font.Bold = true;
                    exSheet.Cells[current_row, 7].Font.Size = 10;

                    current_row += 1;//dong vang huong luong
                    exSheet.Range["A" + current_row + ":" + "F" + current_row].Rows.Merge();
                    exSheet.Cells[current_row, 1].Value = "Số ngày nghỉ được hưởng lương: ";
                    exSheet.Cells[current_row, 1].HorizontalAlignment = XlHAlign.xlHAlignLeft;
                    exSheet.Cells[current_row, 7].Value = grant_total[19]; //ngay nghi huong luong
                    exSheet.Cells[current_row, 7].Font.Bold = true;
                    exSheet.Range["A" + current_row + ":" + "G" + current_row].Font.Size = 10;

                    current_row += 1;//dong vang huong luong
                    exSheet.Range["A" + current_row + ":" + "F" + current_row].Rows.Merge();
                    exSheet.Cells[current_row, 1].Value = "Số ngày nghỉ Không lương: ";
                    exSheet.Cells[current_row, 1].HorizontalAlignment = XlHAlign.xlHAlignLeft;
                    exSheet.Cells[current_row, 7].Value = grant_total[21]; //ngay nghi ko huong luong
                    exSheet.Cells[current_row, 7].Font.Bold = true;
                    exSheet.Range["A" + current_row + ":" + "G" + current_row].Font.Size = 10;

                    current_row += 3;//dong chu ky
                    exSheet.Range["A" + current_row + ":" + "J" + current_row].Rows.Merge();
                    exSheet.Cells[current_row, 1].Value = "Checked By ";
                    exSheet.Cells[current_row, 1].HorizontalAlignment = XlHAlign.xlHAlignCenter;
                    exSheet.Cells[current_row, 1].Font.Size = 18;
                    exSheet.Range["K" + current_row + ":" + "R" + current_row].Rows.Merge();
                    exSheet.Cells[current_row, 11].Value = "Confirm By ";
                    exSheet.Cells[current_row, 11].HorizontalAlignment = XlHAlign.xlHAlignCenter;
                    exSheet.Cells[current_row, 11].Font.Size = 18;
                    exSheet.Range[current_row, 18].Rows.RowHeight = 23;
                    exSheet.Range[current_row - 3, 1, current_row, 18].Borders.LineStyle = XlLineStyle.xlLineStyleNone;


                    IPageBreaks pbs = exBook.Worksheets[1].HPageBreaks;
                    IRange usedrange = exBook.Worksheets[1].UsedRange;
                    pbs.Add(usedrange.Rows[current_row]);


                    for (int k = 0; k < l_col; k++)
                    {
                        grant_total[k] = 0;
                    }



                    current_row += l_fix_row1; //nhung dong tieu de
                    exSheet.Range["A1:S11"].Rows.Copy(exSheet.Range["A" + (current_row - l_fix_row1 + 1) + ":" + "S" + (current_row)], XlPasteType.xlPasteAll);
                    exSheet.Range[current_row - l_fix_row1 + 2, 18].Rows.RowHeight = 23;

                    exSheet.Cells[current_row - l_fix_row1 + 5, 1].Value = "MSNV VÀ TÊN  : " + myDT.Rows[i + 1]["C0"].ToString();
                    exSheet.Cells[current_row - l_fix_row1 + 6, 1].Value = "PHÒNG BAN  : " + myDT.Rows[i + 1]["C1"].ToString();
                    exSheet.Cells[current_row - l_fix_row1 + 7, 1].Value = "BỘ PHẬN  : " + myDT.Rows[i + 1]["C2"].ToString();
                    exSheet.Cells[current_row - l_fix_row1 + 8, 1].Value = "VỊ TRÍ  : " + myDT.Rows[i + 1]["C3"].ToString();

                    stt = 0;


                }
            }


        }

        //dong cuoi cung

        current_row += 1;//dong tong gio lam viec 


        //dong tong so ngay lam viec
        for (int j = 6; j <= 16; j++)
        {
            exSheet.Cells[current_row, j + 1].Value = grant_total[j];
        }

        current_row += 1;//dong tong ngay cong
        exSheet.Cells[current_row, 7].Value = Math.Round(grant_total[6] / 8, 2);

        current_row += 2;//dong ngay le
        exSheet.Cells[current_row, 7].Value = grant_total[20]; //ngay le

        current_row += 1;//dong vang huong luong
        exSheet.Cells[current_row, 7].Value = grant_total[19]; //ngay nghi huong luong

        current_row += 1;//dong vang huong luong
        exSheet.Cells[current_row, 7].Value = grant_total[21]; //ngay nghi ko huong luong
      
		
		exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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
	
	
	
}
