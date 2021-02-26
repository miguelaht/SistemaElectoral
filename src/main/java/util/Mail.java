/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

/*
Send password through email using python smtplib
 */

import io.github.cdimascio.dotenv.Dotenv;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * @author miguelaht
 */
public class Mail {
    private Dotenv dotenv = Dotenv.configure()
            .ignoreIfMalformed()
            .ignoreIfMissing()
            .load();
    public String sendMail(String mail, String path) {
        String s = null;
        String err = null;
        try {
            Process p = Runtime.getRuntime().exec(String.format("/Library/Frameworks/Python.framework/Versions/3.9/bin/python3 %s %s", path, mail));

            BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));

            BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));

            while ((s = stdInput.readLine()) != null) {
                if (s.length() > 0) {
                    return s;
                }
            }

            // read any errors from the attempted command
            while ((err = stdError.readLine()) != null) {
                System.out.println(err);
            }
        } catch (IOException e) {
            System.out.println("exception happened - here's what I know: ");
            e.printStackTrace();
            System.exit(-1);
        }

        return s;
    }
}
