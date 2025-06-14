import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello World!");
        ArrayList<String> list = new ArrayList<>();
        list.add("Hello");
        list.add("World");
        for (String s : list) {
            System.out.println(s);
        }
    }

    void sayHi() {
        System.out.println("Hello");
    }

    public void sayHi2() {
        System.out.println("Hello");
    }
}
