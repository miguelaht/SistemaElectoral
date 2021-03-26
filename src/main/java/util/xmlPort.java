package util;

import database.Dba;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.XMLOutputter;

public class xmlPort {
    private static Dba db;
    private static SAXBuilder builder;
    private static Document docXML;

    public boolean exportXML() throws SQLException {
        try {
            String path = new File(".").getCanonicalPath() + "/votos.xml";
            Element root = new Element("registros"); // xml root
            Element items;

            // get data to export
            db = new Dba();
            db.Conectar();
            db.query.execute("SELECT ID, ID_VOTANTE, ID_CANDIDATO, ESTADO FROM VOTO");
            ResultSet rs = db.query.getResultSet();


            // archivo xml
            XMLOutputter out = new XMLOutputter();
            File fichero = new File(path);
            FileOutputStream outStream = new FileOutputStream(path);


            items = new Element("Votos");


            // add content to root
            while (rs.next()) {
                Element voto = new Element("voto");
                voto.setAttribute("id", rs.getString(1));
                voto.setAttribute("id_votante", rs.getString(2));
                voto.setAttribute("id_candidato", rs.getString(3));
                voto.setAttribute("estado", rs.getString(4));
                items.addContent(voto);
            }

            root.addContent(items);
            out.output(root, outStream);
            outStream.close();

//            db.query.execute("TRUNCATE TABLE VOTO");
            db.desconectar();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean importXML() throws IOException {
        try {
            String path = new File(".").getCanonicalPath() + "/votos.xml";
            db = new Dba();
            db.Conectar();

            // read file
            builder = new SAXBuilder();
            docXML = builder.build(path);
            Element root = docXML.getRootElement();
            Element items = root.getChild("Votos");
            List votos = items.getChildren();

            Element voto;
            for (int i = 0; i < votos.size(); i++) {
                voto = (Element) votos.get(i);
                db.query.execute(
                        String.format("INSERT INTO VOTO (ID_VOTANTE, ID_CANDIDATO, ESTADO) " +
                                      "VALUES ('%s', '%s', %s)",
                                voto.getAttributeValue("id_votante"),
                                voto.getAttributeValue("id_candidato"),
                                voto.getAttributeValue("estado")
                        )
                );
            }

            db.desconectar();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
