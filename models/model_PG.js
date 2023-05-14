import pg from 'pg';
import dotenv from 'dotenv';
import nodemailer from "nodemailer"
import {google} from 'googleapis'
let generateTextID=function(length=10){

    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}

dotenv.config();

const pool = new pg.Pool({
    host: process.env.PGHOST,
    database: process.env.PGDATABASE,
    port: process.env.PGPORT,
    user: process.env.PGUSER,
    password: process.env.PGPASSWORD
});



async function connect(){
    try{
        const client = await pool.connect();
        console.log('Database connection was successful!');
        return client;
    } catch(e){
        console.error(`Failed to connect ${e}`);
    }
}

async function sendEmail(Fname,Lname,wmail,bookingID,ticketID,from,to,date,time){
    try{
        const accessToken=await oAuth2Client.getAccessToken();
        const transport=nodemailer.createTransport({
            service:'Gmail',
            auth:{
                type:'OAuth2',
                user:'airnet.info@gmail.com',
                pass:"airnet1234",
                refreshToken:REFRESHTOKEN,
                accessToken:accessToken
            }
        })
        const mailOptions={
            from:"airnet.info@gmail.com",
            to:`${email}`,
            subject:"Booking Info",
            text:"Booking/Ticket Info - Do not Reply",
            html:`<h1>Booking ID:'${bookingID}' for Mr/Mrs '${Fname}' '${Lname}' </h1> <br>
            <h2>Ticket ID:'${ticketID}'</h2><br>
            <h3>From:'${from}' , To:'${to}'</h3><br>
            <h4>Date:'${date}' , Time:'${time}'`
        }
        console.log(transport.service,transport.auth,`\n MailOptions`,mailOption)
        const result=await transport.sendMail(mailOptions)
        return  result
    }catch(error){return error;}
    
}
async function insertUser (email,password,firstName,lastName,city,streetAddrs,numberAddrs,bdate,age,gender,phonenumber,salt, callback) {
   
    /////FIX///
const sql = `INSERT INTO "user"("email","password","firstName","lastName","city","streetAddrs","numberAddrs","bdate","age","gender","phonenumber","salt") VALUES
 ('${email}','${password}','${firstName}','${lastName}','${city}','${streetAddrs}','${numberAddrs}','${bdate}','${age}','f','${phonenumber}','${salt}') 
 RETURNING "userID"`;
 //const sql2 = `SELECT * FROM "user"`;
    console.log('to insert...', sql)
    // how to return the autoincremented value of an inserted record: https://stackoverflow.com/questions/37243698/how-can-i-find-the-last-insert-id-with-node-js-and-postgresql
    try {
        const client = await connect();
        console.log("29");
        // const res1 = await client.query(sql2);
        //console.log(res1);
        const res = await client.query(sql);
        console.log(res);
        
        
        await client.release();
        console.log(`user inserted`);
        callback(null, [{"userID":res.rows[0].userID,"email": email,"password": password,"firstName": firstName,"lastName": lastName,
        "city": city,"streetAddrs": streetAddrs,"numberAddrs": numberAddrs,"bdate": bdate,"age": age,"gender": gender,"phonenumber": phonenumber }]); 

    } 
    catch (err) {
        callback(null, err);
        }

    
}
async function findUser(email, callback){
    const sql ={text: `SELECT * FROM "user" WHERE "email"=$1 `, values: [email]} /*and "Password"='${Password}`*/;
    console.log(sql)
    try{
        console.log("27")
        const client = await connect();
        console.log("28");
        const res = await client.query(sql);
        console.log(res);

        console.log('user found');
        callback(null, res.rows);
        await client.release();
        
    } catch(err){
        callback(null, err);
    }
    
}


async function findFlights(journeyID, departFrom, arriveTo, departureDate, arrivalDate, callback){

    const sql ={text: `SELECT * FROM "flight" WHERE "departFrom"=$1 AND "arriveTo"=$2 AND "departureDate"=$3 AND "arrivalDate"=$4`, values: [ departFrom, arriveTo, departureDate, arrivalDate]};
    console.log(sql);
    
    try{
        const client  = await connect();
        const res = await client.query(sql);
        console.log(res);

        callback(null, res.rows);
        await client.release();

    }catch(err){
        callback(null, err);
    }
}



// console.log("here is create pass tick relation");
async function createTicketPassengerRelation(userID, data, callback){
    console.log("here is ");

     let date = new Date();
     let bookingID=generateTextID();
     console.log(" I'M HERE",data)
     if (typeof data.lName ==='string'){
        data = {
            cusID: [data.cusID],
            fName: [data.fName],
            lName: [data.lName],
            bdate: [data.bdate]
        }
     }

     try{
        const client  = await connect();
        const res = await client.query(sql3);
        console.log(res);

        const sql7= `INSERT INTO "book"("bookID","userID","journeyID","bookingDate")
        VALUES('${bookingID}','${userID}','${journeyID}','${date}')`;
        console.log(res);
     
        //customer
     const sql = `INSERT INTO "customer"("customerID")
     SELECT "userID" FROM "user" WHERE "userID"= ${userID}`;
    //  console.log("2",sql);
     
     //passenger
     let sql3 = `INSERT INTO "passenger"("cusID","fName","lName","bdate")
     VALUES('${data.cusID}', '${data.fName}', '${data.lName}', '${data.bdate}')`;
     
    //  await client.query(sql3);
    //  console.log("3",sql3);
        
     //belongsTo
     const sql4 = {text: `INSERT INTO "belongsTo"("flightNO","seat_no") 
     SELECT f."flightNO", t."seatNO"
     FROM "flight" as f, "ticket" as t
     WHERE f."flightNO"=$1 and t."seatNO"=$2`, values: [flightNO, seatNO]};
    
    //  console.log(sql4 ,"this is sql4");
    // await client.query(sql4);

    //receives
    const sql5 = `INSERT INTO "receives"("custID", "ticketID")
    SELECT c."customerID", t."ticketID"
    FROM "customer" as c, "ticket" as t
    WHERE c."customerID"='${userID}' AND t."ticketID"="ticketID"`;
        // console.log("5",sql5);


    callback( null, bookingID, sql);
    client.release();

    //LAST LINE OF CODE
    //sendEmail(passenger.Fname,passenger.Lname,passenger.Email,bID,ticketID,resF.rows[0].startAirportID,resF.rows[0].finishAirportID,
    //resF.rows[0].departureDate,resF.rows[0].departureTime).then(result=> 
    //console.log('Email sent...',result)).catch((error)=>console.log(error.message))
    }catch(err){
        callback(null,err);
    }
};


async function checkBookingID(bookID,userID,journeyID,callback){

    const sql={text:`SELECT * FROM "book" WHERE "bookID"=$11`,values:[bookID]}
    try{
        const client=await connect();
        const res=await client.query(sql);
        let bookingDate=new Date();
        if(jQuery.isEmptyObject(res)){
            const action=await client.query(`INSERT INTO "book"("bookID","userID","journeyID","bookingDate")
            VALUES('${bookID}','${userID}','${journeyID}','${bookingDate}')`);
            await client.release();
            
        }
        else{
            callback(null,row[0]);
            await client.release();
        }
    }catch(error){
        callback(null,error)
    }
}




export {insertUser, findUser, findFlights, checkBookingID, createTicketPassengerRelation};