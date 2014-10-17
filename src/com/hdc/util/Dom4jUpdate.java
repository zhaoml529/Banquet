package com.hdc.util;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.Iterator;
import java.util.List;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

public class Dom4jUpdate {
	 public void createXML() {
	        //�ù����ഴ��һ��documentʵ��
	        Document doc = DocumentHelper.createDocument();
	        //������Ԫ��emps
	        Element rootEle = doc.addElement("hotel");
	        //���ע��
	       // rootEle.addComment("����һ��dom4j���ɵ�xml�ļ�");
	        
	        for(int i=0;i<10;i++){
	        	//emps���ڵ��´���һ��emp�ڵ�
		        Element empEle = rootEle.addElement("picture");
	        	//emp�������id="1"
		        empEle.addAttribute("id", String.valueOf(i));
		        //emp�ڵ��´���һ��name�ڵ�
		        Element nameEle = empEle.addElement("url");
		        //name�ڵ��´���һ���ı��ڵ�zhangsan
		        nameEle.setText("pictureURL "+i);
		        //��Ϊname�ڵ㴴��һ���ֵܽڵ�
//		        Element sexEle = empEle.addElement("sex");
//		        sexEle.setText("man-"+i);
	        }
	        
	        //��document�е�����д���ļ���
	        try {
	            Writer out = new FileWriter("F:\\emps.xml");
	            //��ʽ�����,����IE���һ��
	            OutputFormat format = OutputFormat.createPrettyPrint();
	            //OutputFormat format = OutputFormat.createCompactFormat();
	            format.setEncoding("UTF-8");
	            //����д������
	            XMLWriter writer = new XMLWriter(out,format);
	            writer.write(doc);
	            writer.close();
	            System.out.println("����emps.xml�ɹ���");
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	            System.out.println("ʧ���ˡ�");
	        }
	    }

	 public void updateXML(){
	        try {
	            //�����������
	            SAXReader reader = new SAXReader();
	            //����documentʵ��
	            Document doc = reader.read("F:\\emps.xml");
	            //���ҽڵ�emp�µ�id����
	            List<Object> listAttr = doc.selectNodes("/hotel/picture/@id");
	            System.out.println(listAttr.size()+"!!!!");
	            Iterator<Object> itAttr = listAttr.iterator();
	            while(itAttr.hasNext()){
	                Attribute attr = (Attribute) itAttr.next();
//	                if("5".equals(attr.getValue())){
//	                	System.out.println(attr.getDocument());
//	                	System.out.println(attr.getParent());
//	                	
//	                	System.out.println(attr.getValue());
//	                	//attr.setValue("888");
//	                }
	                System.out.println(attr.getValue()+"-----");
	                //emp�����޸�Ϊ001
	            }
	            //����emp�µ�name�ڵ�
	            List<Object> listText = doc.selectNodes("/hotel/picture/url");
	            System.out.println("urlList: "+listText.size());
	            Iterator<Object> itText = listText.iterator();
	            while(itText.hasNext()){
	                Element textEle = (Element) itText.next();
	                //name�ڵ���ı������޸�Ϊ"����"
	                //textEle.setText("update-picURL");
	                System.out.println(textEle.getText());
	            }
	            //����emp�ڵ�
//	            List<Object> listEle = doc.selectNodes("/pictures/hotel");
//	            Iterator<Object> itEle = listEle.iterator();
//	            while(itEle.hasNext()){
//	                Element empEle = (Element) itEle.next();
//	                System.out.println(empEle);
//	                //����emp�µ�sex�ڵ�
//	                Iterator<Object> itSex = empEle.elementIterator("sex");
//	                while(itSex.hasNext()){
//	                    Element sexEle = (Element) itSex.next();
//	                    //ɾ��sex�ڵ�
//	                    empEle.remove(sexEle);
//	                }
//	            }
	            //����д����
	            Writer out = new FileWriter("F:\\emps(update).xml");
	            // ��ʽ�����
	            OutputFormat format = OutputFormat.createPrettyPrint();
	            //OutputFormat format = OutputFormat.createCompactFormat();
	            format.setEncoding("UTF-8");
	            //����д������
	            XMLWriter writer = new XMLWriter(out,format);
	            writer.write(doc);
	            writer.close();
	            System.out.println("����emps(update).xml�ɹ�!!!");
	            
	        } catch (Exception e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	 }
	public static void main(String[] args) {
		new Dom4jUpdate().createXML();
		//new Dom4jUpdate().updateXML();
	}
}