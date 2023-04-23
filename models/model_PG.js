import pg from 'pg';
import dotenv from 'dotenv';


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

async function insertUser (userID,email,password,firstName,lastName,city,streetAddrs,numberAddrs,bdate,age,gender,phonenumber,salt, callback) {
   
    /////FIX///
const sql = `INSERT INTO "User"("userID","email","password","firstName","lastName","city","streetAddrs","numberAddrs","bdate","age","gender","phonenumber","salt") VALUES
 ('${email}','${password}','${firstName}','${lastName}','${city}','${streetAddrs}','${numberAddrs}','${bdate}','${age}','${gender}','${phonenumber}','${salt}') 
 RETURNING "userID"`;
    console.log('to insert...', sql)
    // how to return the autoincremented value of an inserted record: https://stackoverflow.com/questions/37243698/how-can-i-find-the-last-insert-id-with-node-js-and-postgresql
    try {
        const client = await connect();
        console.log('29');
        const res = await client.query(sql);
        console.log(res);
        
        await client.release();
        console.log(`user inserted`);
        callback(null, [{"userID":res.rows[0].userID,"email": email,"password": password,"firstName": firstName,"lastName": lastName,
        "city": city,"streetAddrs": streetAddrs,"numberAddrs": numberAddrs,"bdate": bdate,"age": age,"gender": gender,"phonenumber": phonenumber, "salt": salt }]); 

    } 
    catch (err) {
        callback(null, err);
        }

    
}

async function findUser(email, password, callback){
    const sql ={text: `SELECT * FROM "user" WHERE "email"=$1 and "password"=$2`, values: [email, password]} /*and "Password"='${Password}`*/;

    try{
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


export { connect, insertUser};