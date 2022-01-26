const express = require('express');
const router = express.Router();
const  db  = require("../config/dbConfig");
const mysql = require('mysql');


router.get('/', (req,res) => {
    res.render("index");
});

router.get('/aru', async (req, res) => {
    db.query('SELECT * FROM aru', (err,result) =>{
        if (err) throw err;
        let removed = req.query.removed;
        return res.render("aru", {
            aruk : result,
            removed : removed
        });
    });
});

router.get('/atvevo', (req,res) => {
    db.query(`SELECT * FROM atvevo; SELECT * FROM helyszin;`, (err,result) =>{
        if (err) throw err;
        let removed = req.query.removed;
        return res.render("atvevo", {
            atvevok : result[0],
            helyszinek : result[1],
            removed : removed
        });
    });
});

router.get('/beszallito', (req,res) => {
    db.query('SELECT * FROM beszallito', (err,result) =>{
        if (err) throw err;
        let removed = req.query.removed;
        return res.render("beszallito", {
            beszallitok : result,
            removed:removed
        });
    });
});

router.get('/behozatal', (req,res) => {
    db.query(`SELECT * FROM behozatal; SELECT * FROM stored_behozatal;`, (err,result) =>{
        if (err) throw err;
        let removed = req.query.removed;
        return res.render("behozatal", {
            behozatalok : result[0],
            stored_behozatalok : result[1],
            removed : removed
        });
    });
});

router.get('/kiadas', (req,res) => {
    db.query(`SELECT * FROM kiadas; SELECT * FROM stored_kiadas;`, (err,result) =>{
        if (err) throw err;
        let removed = req.query.removed;
        return res.render("kiadas", {
            kiadasok : result[0],
            stored_kiadasok : result[1],
            removed : removed
        });
    });
});

router.get('/statisztika', (req,res)=>{
    db.query(`SELECT vezeteknev, keresztnev, SUM(mennyiseg) as db FROM atvevo, stored_kiadas WHERE atvevo.id = stored_kiadas.satvevo_id AND termeknev="alma" GROUP BY atvevo.id ORDER BY mennyiseg desc LIMIT 1;
              SELECT vezeteknev, keresztnev FROM atvevo WHERE id IN (SELECT id FROM helyszin WHERE telepules = "Tunyogmatolcs");
              SELECT nev, COUNT(sbeszallito_id) as db FROM stored_behozatal, beszallito WHERE stored_behozatal.sbeszallito_id = beszallito.id GROUP BY sbeszallito_id LIMIT 1;
              SELECT vezeteknev, keresztnev FROM atvevo WHERE id NOT IN (SELECT id FROM stored_kiadas WHERE termeknev <> "tej") ORDER BY vezeteknev;
              SELECT nev, mennyiseg FROM aru ORDER BY mennyiseg; `, (err, result)=>{
                 if (err) throw err;
                 return res.render("statisztika",{
                     maxalmak : result[0][0],
                     tlakosok : result[1],
                     lbeszallito : result[2][0],
                     nemvittek : result[3],
                     aruk : result[4]
                 });
             });
   //return res.render("statisztika");
});

router.get('/addaru', (req, res) =>{
    let added = req.query.added;
    res.render("add-aru",{
        added : added
    });
});

router.get('/addatvevo', (req, res) =>{
    let added = req.query.added;
    res.render("add-atvevo", {
        added: added
    });
});

router.get('/addhelyszin', (req, res) =>{
    let added = req.query.added;
    res.render("add-helyszin",{
        added: added
    });
});

router.get('/addbeszallito', (req, res) =>{
    let added = req.query.added;
    res.render("add-beszalito",{
        added: added
    });
});

router.get('/addbehozatal', (req, res) =>{
    let added = req.query.added;
    res.render("add-behozatal", {
        added: added
    });
});

router.get('/addkiadas', (req, res) =>{
    let added = req.query.added;
    res.render("add-kiadas", {
        added: added
    });
});

router.post('/deletedb', (req,res) =>{
    let sql = 'DROP DATABASE IF EXISTS raktar';
    db.query(sql, (err) => {
        if (err) {
            throw err;
        }
    return  res.redirect('/');
    });
});

router.get('/deletearu/:id', (req,res)=>{
   let id = req.params.id;
    db.query('DELETE FROM aru WHERE id=('+id+')',[parseInt(id)], (err) =>{
        if (err) throw err;
        let removed = "delete sucessfull"
        return res.redirect('/aru?removed='+removed);
    });
});

router.get('/deleteatvevo/:id', (req,res)=>{
    let id = req.params.id;
    db.query('DELETE FROM atvevo WHERE id=('+id+')',[parseInt(id)], (err) =>{
        if (err) throw err;
        let removed = "delete sucessfull"
        return res.redirect('/atvevo?removed='+removed);
    });
});

router.get('/deletehelyszin/:id', (req,res)=>{
    let id = req.params.id;
    db.query('DELETE FROM helyszin WHERE id=('+id+')',[parseInt(id)], (err) =>{
        if (err) throw err;
        let removed = "delete sucessfull"
        return res.redirect('/atvevo?removed='+removed);
    });
});

router.get('/deletebeszallito/:id', (req,res)=>{
    let id = req.params.id;
    db.query('DELETE FROM beszallito WHERE id=('+id+')',[parseInt(id)], (err) =>{
        if (err) throw err;
        let removed = "delete sucessfull"
        return res.redirect('/beszallito?removed='+removed);
    });
});

router.get('/deletebehozatal/:id', (req,res)=>{
    let id = req.params.id;
    db.query('DELETE FROM stored_behozatal WHERE id=('+id+')',[parseInt(id)], (err) =>{
        if (err) throw err;
        let removed = "delete sucessfull"
        return res.redirect('/behozatal?removed='+removed);
    });
});

router.get('/deletekiadas/:id', (req,res)=>{
    let id = req.params.id;
    db.query('DELETE FROM stored_kiadas WHERE id=('+id+')',[parseInt(id)], (err) =>{
        if (err) throw err;
        let removed = "delete sucessfull"
        return res.redirect('/kiadas?removed='+removed);
    });
});

router.post("/add-aru", (req,res) => {
    let {nev} = req.body;
    let {egysegar} = req.body;
    let {mennyiseg} = req.body;
    if (nev === '' || egysegar === '' || mennyiseg === ''){
        let added = "Error";
        res.redirect("/addaru?added="+added)
    } else {
        db.query(`INSERT INTO aru (nev, egysegar, mennyiseg) VALUES ('${nev}', '${egysegar}', '${mennyiseg}')`, [nev, egysegar, mennyiseg]);
        res.redirect('/aru');
    }
});

router.post("/add-atvevo", (req,res) => {
    let {vezeteknev} = req.body;
    let {keresztnev} = req.body;
    let {email} = req.body;
    let {telefonszam} = req.body;
    if (vezeteknev === '' || keresztnev === '' || email === '' || telefonszam === ''){
        let added = "Error";
        res.redirect("/addatvevo?added="+added);
    } else {
        db.query(`INSERT INTO atvevo (vezeteknev, keresztnev, email, telefonszam) VALUES ('${vezeteknev}', '${keresztnev}', '${email}', '${telefonszam}')`, [vezeteknev, keresztnev, email, telefonszam]);
        res.redirect('/atvevo');
    }
});

router.post("/add-helyszin", (req,res) => {
    let {hatvevo_id} = req.body;
    let {iranyitoszam} = req.body;
    let {telepules} = req.body;
    let {utca} = req.body;
    let {hazszam} = req.body;
    let {egyeb} = req.body;
    if (hatvevo_id === "" || iranyitoszam === "" ||telepules === "" || utca === "" || hazszam === ""){
        let added = "Error";
        res.redirect('/addhelyszin?added='+added);
    } else {
        db.query(`INSERT INTO helyszin (hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('${hatvevo_id}', '${iranyitoszam}', '${telepules}', '${utca}', '${hazszam}', '${egyeb}')`, [hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb]);
        res.redirect('/atvevo');
    }
});

router.post("/add-beszallito", (req,res) => {
    let {nev} = req.body;
    let {telefonszam} = req.body;
    if (nev === "" || telefonszam === ""){
        let added = "Error";
        res.redirect("/addbeszallito?added="+added);
    } else {
        db.query(`INSERT INTO beszallito (nev, telefonszam) VALUES ('${nev}', '${telefonszam}')`, [nev, telefonszam]);
        res.redirect('/beszallito');
    }
});

router.post("/add-behozatal", (req,res) => {
    let {termeknev} = req.body;
    let {mennyiseg} = req.body;
    let {egysegar} = req.body;
    let {beszallito_id} = req.body;
    if (termeknev === "" || mennyiseg === "" || egysegar === "" || beszallito_id === ""){
        let added = "Error";
        res.redirect("/addbehozatal?added="+added);
    } else {
        db.query(`INSERT INTO behozatal (termeknev, mennyiseg, egysegar, beszallito_id) VALUES ('${termeknev}', '${mennyiseg}', '${egysegar}', '${beszallito_id}')`, [termeknev, mennyiseg, egysegar, beszallito_id]);
        db.query(`UPDATE aru SET mennyiseg = mennyiseg +(SELECT mennyiseg FROM behozatal WHERE EXISTS (SELECT nev FROM aru WHERE nev = termeknev)) WHERE nev = '${termeknev}' LIMIT 1; `)
        db.query(`INSERT INTO aru (nev, mennyiseg, egysegar) SELECT termeknev, mennyiseg, egysegar FROM behozatal WHERE NOT EXISTS( SELECT nev FROM aru  WHERE nev = termeknev) LIMIT 1;`)
        db.query(`INSERT INTO stored_behozatal (termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES('${termeknev}', '${mennyiseg}', '${egysegar}', '${beszallito_id}')`, [termeknev, mennyiseg, egysegar, beszallito_id]);
        db.query(`DELETE FROM behozatal`);
        res.redirect('/behozatal');
    }
});

router.post("/add-kiadas", (req,res) => {
    let {termeknev} = req.body;
    let nev = termeknev;
    let {mennyiseg} = req.body;
    let {datum} = req.body;
    let {atvevo_id} = req.body;
    if (termeknev === "" || mennyiseg === "" || datum === "" || atvevo_id === ""){
        let added = "Error";
        res.redirect("/addkiadas?added="+added)
    } else {
        db.query(`INSERT INTO kiadas (termeknev, mennyiseg, datum, atvevo_id) VALUES ('${termeknev}', '${mennyiseg}', '${datum}', '${atvevo_id}')`, [termeknev, mennyiseg, datum, atvevo_id]);
        db.query(`UPDATE aru SET mennyiseg = mennyiseg -(SELECT mennyiseg FROM kiadas WHERE EXISTS (SELECT nev FROM aru WHERE nev = termeknev)) WHERE nev = '${termeknev}' LIMIT 1; `)
        db.query(`INSERT INTO stored_kiadas (termeknev, mennyiseg, datum, satvevo_id) VALUES('${termeknev}', '${mennyiseg}', '${datum}', '${atvevo_id}')`, [termeknev, mennyiseg, datum, atvevo_id]);
        db.query(`DELETE FROM kiadas`);
        res.redirect('/kiadas');
    }
});


router.get('/editaru/:id', (req, res) =>{
    let id = req.params.id;
    db.query(`SELECT * FROM aru WHERE id = ('${id}')`, (err,result) => {
        if (err) throw err;
        return res.render("update-aru", {
            model : result[0]
        });
    });
});

router.get('/editatvevo/:id', (req, res) =>{
    let id = req.params.id;
    db.query(`SELECT * FROM atvevo WHERE id = ('${id}')`, (err,result) => {
        if (err) throw err;
        return res.render("update-atvevo", {
            model : result[0]
        });
    });
});

router.get('/edithelyszin/:id', (req, res) =>{
    let id = req.params.id;
    db.query(`SELECT * FROM helyszin WHERE id = ('${id}')`, (err,result) => {
        if (err) throw err;
        return res.render("update-helyszin", {
            model : result[0]
        });
    });
});

router.get('/editbeszallito/:id', (req, res) =>{
    let id = req.params.id;
    db.query(`SELECT * FROM beszallito WHERE id = ('${id}')`, (err,result) => {
        if (err) throw err;
        return res.render("update-beszallito", {
            model : result[0]
        });
    });
});

router.get('/editbehozatal/:id', (req, res) =>{
    let id = req.params.id;
    db.query(`SELECT * FROM stored_behozatal WHERE id = ('${id}')`, (err,result) => {
        if (err) throw err;
        return res.render("update-behozatal", {
            model : result[0]
        });
    });
});

router.get('/editkiadas/:id', (req, res) =>{
    let id = req.params.id;
    db.query(`SELECT * FROM stored_kiadas WHERE id = ('${id}')`, (err,result) => {
        if (err) throw err;
        return res.render("update-kiadas", {
            model : result[0]
        });
    });
});

router.post("/updatearu", (req,res) => {
    let {id} = req.body;
    let {nev} = req.body;
    let {egysegar} = req.body;
    let {mennyiseg} = req.body;
    db.query(`UPDATE aru SET nev = '${nev}', egysegar = '${egysegar}', mennyiseg = '${mennyiseg}' WHERE id = '${id}' `);
    return res.redirect('/aru');
});

router.post("/updateatvevo", (req,res) => {
   let {id} = req.body;
   let {vezeteknev} = req.body;
   let {keresztnev} = req.body;
   let {email} = req.body;
   let {telefonszam} = req.body;
   db.query(`UPDATE atvevo SET vezeteknev = '${vezeteknev}', keresztnev = '${keresztnev}', email = '${email}', telefonszam = '${telefonszam}' WHERE id = '${id}' `);
   return res.redirect('/atvevo')
});

router.post("/updatehelyszin", (req,res)=> {
   let {id} = req.body;
   let {hatvevo_id} = req.body;
   let {iranyitoszam} = req.body;
   let {telepules} = req.body;
   let {utca} = req.body;
   let {hazszam} = req.body;
   let {egyeb} = req.body;
   db.query(`UPDATE helyszin SET hatvevo_id = '${hatvevo_id}', iranyitoszam = '${iranyitoszam}', telepules = '${telepules}', utca = '${utca}', hazszam = '${hazszam}', egyeb = '${egyeb}' WHERE id = '${id}'`);
   return res.redirect('/atvevo');
});

router.post("/updatebeszallito", (req,res)=>{
   let {id} = req.body;
   let {nev} = req.body;
   let {telefonszam} = req.body;
   db.query(`UPDATE beszallito SET nev = '${nev}', telefonszam = '${telefonszam}' WHERE id = '${id}'`);
   return res.redirect('/beszallito');
});

router.post('/updatebehozatal', (req,res)=>{
   let {id} = req.body;
   let {termeknev} = req.body;
   let {mennyiseg} = req.body;
   let {egysegar} = req.body;
   let {beszallito_id} = req.body;
   db.query(`UPDATE stored_behozatal SET termeknev = '${termeknev}', mennyiseg = '${mennyiseg}', egysegar = '${egysegar}', sbeszallito_id = '${beszallito_id}' WHERE id = '${id}'`);
   return res.redirect('/behozatal');
});

router.post('/updatekiadas', (req,res)=>{
   let {id} = req.body;
   let {termeknev} = req.body;
   let {mennyiseg} = req.body;
   let {datum} = req.body;
   let {atvevo_id} = req.body;
   db.query(`UPDATE stored_kiadas SET termeknev = '${termeknev}', mennyiseg = '${mennyiseg}', datum = '${datum}', satvevo_id = '${atvevo_id}' WHERE id = '${id}'`);
   return res.redirect('/kiadas');
});

module.exports = router;