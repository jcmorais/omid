package org.apache.omid.transaction;

import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.util.Bytes;

import java.io.IOException;

/**
 * Created by carlosmorais on 22/03/2017.
 */
public class Run {
    public static final byte[] family = Bytes.toBytes("MY_CF");
    public static final byte[] qualifier = Bytes.toBytes("MY_Q");


    public static void main(String[] args) throws IOException, InterruptedException {

        TransactionManager tm = HBaseTransactionManager.newInstance();
        TTable tTable = new TTable("MY_TEST");

        // start the transacrion
        Transaction tx0 = tm.begin();

        // create a row with the key:1000
        Put p = new Put(Bytes.toBytes("1001"));
        // add data
        p.addColumn(family, qualifier, Bytes.toBytes("value1"));
        tTable.put(tx0, p);


        try {
            tm.commit(tx0);
        } catch (RollbackException e) {
            e.printStackTrace();
        }
        System.out.println("fim...");
        System.exit(0);



    }
}
