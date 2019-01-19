
package com.os.admin.utils;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

/**
 * 
 *
 * <p>Title: ExcelUtils.java</p> <p>Description: ExcelUtils.java</p>
 * <p>Copyright: Copyright (c) 2019</p> <p>Company: FPI </p>
 * @author 18163
 * @version 1.0
 * @creattime 2019年1月19日 上午10:06:49
 */
public class ExcelUtils
{
	private final static Logger logger = LogManager.getLogger(ExcelUtils.class);

	// 去读Excel的方法readExcel，该方法的入口参数为一个File对象
	public static List<List<String>> readExcel(MultipartFile file)
	{
		try
		{
			// 创建输入流，读取Excel
			InputStream is = file.getInputStream();
			// jxl提供的Workbook类
			Workbook wb = Workbook.getWorkbook(is);
			// Excel的页签数量
			int sheet_size = wb.getNumberOfSheets();
			for(int index = 0 ; index < sheet_size ; index++)
			{
				List<List<String>> outerList = new ArrayList<>();
				// 每个页签创建一个Sheet对象
				Sheet sheet = wb.getSheet(index);
				// sheet.getRows()返回该页的总行数
				for(int i = 0 ; i < sheet.getRows() ; i++)
				{
					List<String> innerList = new ArrayList<>();
					// sheet.getColumns()返回该页的总列数
					for(int j = 0 ; j < sheet.getColumns() ; j++)
					{
						String cellinfo = sheet.getCell(j, i).getContents();
						if(StringUtils.isEmpty(cellinfo))
						{
							innerList.add(null);
						}
						else
						{
							innerList.add(cellinfo);
						}
					}
					outerList.add(i, innerList);
					logger.info(outerList);
				}
				return outerList;
			}
		}
		catch (FileNotFoundException e)
		{
			logger.error("Excel读取失败", e);
		}
		catch (BiffException e)
		{
			logger.error("Excel读取失败", e);
		}
		catch (IOException e)
		{
			logger.error("Excel读取失败", e);
		}
		return null;
	}
}
