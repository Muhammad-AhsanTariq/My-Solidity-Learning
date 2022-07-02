// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
 contract structs{

     struct Student{
     string name;
     uint rollno;
     uint age;
     bool ispass;}
     
Student[] public student;
     function createstudentrecord (string memory name, uint rollno, uint age, bool ispass)public{
student.push(Student(name,rollno,age,ispass));
     }
     function getstudentrecord(uint _index) public view returns(string memory,uint,uint,bool){
        Student storage studenta = student[_index];
        return (studenta.name,studenta.rollno,studenta.age,studenta.ispass);
     }
     
     
     }
