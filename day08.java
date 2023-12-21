import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class day08 {
    public static void main(String[] args) throws IOException {
        String path = "Input/input8.txt";
        BufferedReader rd = new BufferedReader(new FileReader(new File(path)));

        String[] lr = rd.readLine().split("");
        String line = rd.readLine();

        Map<String,String[]> nodes = new HashMap<>();
        ArrayList<String> starts = new ArrayList<>();

        while ((line = rd.readLine()) != null){
            nodes.put(line.split(" = ")[0],line.split(" = ")[1].replaceAll("[( )]","").split(","));
            if (line.split(" = ")[0].endsWith("A")) starts.add(line.split(" = ")[0]);
        }
            
        String me = "AAA";
        Integer res1 = 0;
        while(!me.equals("ZZZ")) 
            me = nodes.get(me)[lr[res1++%lr.length].equals("L") ? 0 : 1];
        
        ArrayList<Long> res2 = new ArrayList<>();
        for (String key : starts) {
            Integer n = 0;
            while(!key.endsWith("Z"))
                key = nodes.get(key)[lr[n++%lr.length].equals("L") ? 0 : 1];  
            res2.add(n.longValue());
        }

        System.out.println("Answer 1: " + res1);
        System.out.println("Answer 2: " + lcm(res2));

    }


    public static long gcd(long num1, long num2) {
        return num2 == 0 ? num1 : gcd(num2, num1 % num2);
    }
    public static long lcm(ArrayList<Long> arr) {
        return arr.stream().reduce((long)1, (a,b) -> a * b / gcd(a,b));
    }
}