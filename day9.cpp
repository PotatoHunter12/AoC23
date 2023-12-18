#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>

int main() {
    std::ifstream inputFile("Input/input9.txt");
    std::string line;

    int r1 = 0;
    int r2 = 0;

    while (std::getline(inputFile, line)) {
        std::istringstream iss(line);
        std::vector<int> num;

        int s = 1;
        int n;
        
        while (iss >> n) num.push_back(n);

        while (!num.empty()){
            r1 += num.back();
            r2 += num.front()*s;
            s = -s;
            
            std::vector<int> temp;
            for (size_t i = 1; i < num.size(); ++i) {
                temp.push_back(num[i] - num[i - 1]);
            }
            num = temp;
        }
    }
    inputFile.close();

    std::cout << "Answer 1: " << r1 << std::endl;
    std::cout << "Answer 2: " << r2 << std::endl;
    
    return 0;
}