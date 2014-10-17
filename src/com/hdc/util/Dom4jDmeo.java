package com.hdc.util;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

 
import org.w3c.dom.*; 
import org.xml.sax.SAXException;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source; 
import javax.xml.transform.Transformer;  

import javax.xml.transform.TransformerFactory; 
import javax.xml.transform.dom.DOMSource; 
import javax.xml.transform.stream.StreamResult;

public class Dom4jDmeo {
	/**
	 * @ClassName: Dom4jDmeo
	 * @Description:TODO(这里用一句话描述这个类的作用)
	 * @author: mzj
	 * @date: 2014-4-21 下午09:00:55
	 *
	 */
	/*static void readXML(String path){
		SAXReader reader = new SAXReader();
		try{
			Document doc = reader.read(path);
			List nameList = doc.selectNodes("//books/book/name");
			List priceList = doc.selectNodes("//books/book/price");
			List memoList = doc.selectNodes("//books/book/memo");
			Element root = doc.getRootElement();
			System.out.println("根节点"+root.getName());
			for(int i = 0;i<nameList.size();i++){
				StringBuilder sb = new StringBuilder();
				sb.append("name= "+((Element)nameList.get(i)).getTextTrim()+"	");
				sb.append("price= "+((Element)priceList.get(i)).getTextTrim()+"	");
				sb.append("memo= "+((Element)memoList.get(i)).getTextTrim()+"	");
				System.out.println(sb.toString());
			}
			Iterator<?> it = root.elementIterator();
		}catch(DocumentException e){
				e.printStackTrace();
			}
	}*/
	static List<Element> readXML(String path){
		SAXReader reader = new SAXReader();
		List<Element> valueList = new ArrayList<Element>();
		try{
			Document doc = reader.read(path);
			valueList = doc.selectNodes("//picture/value");
			Element root = doc.getRootElement();
			System.out.println("根节点"+root.getName());
			for(int i = 0;i<valueList.size();i++){
//				StringBuilder sb = new StringBuilder();
//				sb.append("value = "+((Element)valueList.get(i)).getTextTrim()+" ");
//				System.out.println(sb.toString());
				System.out.println(valueList.get(i));
				System.out.println(((Element) valueList.get(i)).getTextTrim());
			}
		}catch(DocumentException e){
				e.printStackTrace();
			}
		return valueList;
		}
	
	
	static void findXML(String path){
		SAXReader reader=new SAXReader();
		try{
			Document doc = reader.read(path);
			//Element root = doc.getRootElement();
			Node node = doc.selectSingleNode("//picture/value");
			System.out.println(node.getText());
		}catch(DocumentException e){
			e.printStackTrace();
		}
	}
	static void writeXML(String path , List<Element> valueList){    
		//构建xml输出对象 
         try {    
             OutputFormat fmt = OutputFormat.createPrettyPrint();
             fmt.setEncoding("UTF-8");
        	 XMLWriter writer = new XMLWriter(new FileOutputStream(path),fmt);
             Document doc=DocumentHelper.createDocument();
        //创建文档对象 
             
             Element root=doc.addElement("picture");  
             for(int i = 0;i<valueList.size();i++){
            	 root.addElement("value").addText(((Element) valueList.get(i)).getTextTrim());
             }
		   //  root.addElement("value").addText("asdasdadsadsadsasd132312312");
		     //root.addElement("value").addText("asdasdadsadsadsasxxxxxxxxd");
		
		   //构建子节点，属性值和显示文本     
		   writer.write(doc);
		   //输出文档对象   
		   writer.close();  
		   } catch (IOException e)
		   {  
			   e.printStackTrace(); 
		   }
	}
		   
	public static void main(String[] args) 
	{  
	   
		
		List<Element> valueList = Dom4jDmeo.readXML("d:/test.xml");
		//System.out.println(valueList);
		//valueList.add(e);
		//Dom4jDmeo.writeXML("d:/test.xml",valueList);
		//Dom4jDmeo.findXML("d:/test.xml"); 
	
	}
	
	}


