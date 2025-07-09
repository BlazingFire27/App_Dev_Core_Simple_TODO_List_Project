const express = require("express");

const router = express.Router();

const taskController = require("../controllers/task.controller");

router.post("/create", taskController.createTask);
router.get("/all", taskController.getTasks);
router.put("/update", taskController.updateTask);

module.exports = { TaskRouter: router };
