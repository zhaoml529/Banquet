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
	        //用工厂类创建一个document实例
	        Document doc = DocumentHelper.createDocument();
	        //创建根元素emps
	        Element rootEle = doc.addElement("hotel");
	        //添加注释
	       // rootEle.addComment("这是一个dom4j生成的xml文件");
	        
	        for(int i=0;i<10;i++){
	        	//emps根节点下创建一个emp节点
		        Element empEle = rootEle.addElement("picture");
	        	//emp添加属性id="1"
		        empEle.addAttribute("id", String.valueOf(i));
		        //emp节点下创建一个name节点
		        Element nameEle = empEle.addElement("url");
		        //name节点下创建一个文本节点zhangsan
		        nameEle.setText("pictureURL "+i);
		        //再为name节点创建一个兄弟节点
//		        Element sexEle = empEle.addElement("sex");
//		        sexEle.setText("man-"+i);
	        }
	        
	        //将document中的内容写入文件中
	        try {
	            Writer out = new FileWriter("F:\\emps.xml");
	            //格式化输出,类型IE浏览一样
	            OutputFormat format = OutputFormat.createPrettyPrint();
	            //OutputFormat format = OutputFormat.createCompactFormat();
	            format.setEncoding("UTF-8");
	            //创建写出对象
	            XMLWriter writer = new XMLWriter(out,format);
	            writer.write(doc);
	            writer.close();
	            System.out.println("生成emps.xml成功。");
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	            System.out.println("失败了。");
	        }
	    }

	 public void updateXML(){
	        try {
	            //创建读入对象
	            SAXReader reader = new SAXReader();
	            //创建document实例
	            Document doc = reader.read("F:\\emps.xml");
	            //查找节点emp下的id属性
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
	                //emp属性修改为001
	            }
	            //查找emp下的name节点
	            List<Object> listText = doc.selectNodes("/hotel/picture/url");
	            System.out.println("urlList: "+listText.size());
	            Iterator<Object> itText = listText.iterator();
	            while(itText.hasNext()){
	                Element textEle = (Element) itText.next();
	                //name节点的文本内容修改为"张三"
	                //textEle.setText("update-picURL");
	                System.out.println(textEle.getText());
	            }
	            //查找emp节点
//	            List<Object> listEle = doc.selectNodes("/pictures/hotel");
//	            Iterator<Object> itEle = listEle.iterator();
//	            while(itEle.hasNext()){
//	                Element empEle = (Element) itEle.next();
//	                System.out.println(empEle);
//	                //查找emp下的sex节点
//	                Iterator<Object> itSex = empEle.elementIterator("sex");
//	                while(itSex.hasNext()){
//	                    Element sexEle = (Element) itSex.next();
//	                    //删除sex节点
//	                    empEle.remove(sexEle);
//	                }
//	            }
	            //创建写出流
	            Writer out = new FileWriter("F:\\emps(update).xml");
	            // 格式化输出
	            OutputFormat format = OutputFormat.createPrettyPrint();
	            //OutputFormat format = OutputFormat.createCompactFormat();
	            format.setEncoding("UTF-8");
	            //创建写出对象
	            XMLWriter writer = new XMLWriter(out,format);
	            writer.write(doc);
	            writer.close();
	            System.out.println("生成emps(update).xml成功!!!");
	            
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