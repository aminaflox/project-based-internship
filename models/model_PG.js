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
        console.log('29');
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


export {insertUser, findUser};