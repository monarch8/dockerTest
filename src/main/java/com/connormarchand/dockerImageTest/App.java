package com.connormarchand.dockerImageTest;

import java.io.*;
import java.util.Scanner;

/**
 * Accept input add 5 and print out new number
 *
 * @author Connor Marchand
 *
 */
public class App 
{
    public static void main( String[] args )
    {
        //Declares and initalizes variab;es
        int input;
        Scanner in = new Scanner(System.in);


        System.out.println( "Enter Number:" );

        input = in.nextInt();

        System.out.println(input+5 +" (plus five)");
    }
}
