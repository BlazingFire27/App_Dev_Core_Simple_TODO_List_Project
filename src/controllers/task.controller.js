const Task = require("../models/Task");

exports.createTask = async (req, res) => {
  try {
    const { userId, title, description } = req.body;

    if (!userId) {
      return res.status(400).json({ message: "userId is required" });
    }
    if (!title) {
      return res.status(400).json({ message: "Title is must" });
    }

    const newTask = new Task({
      userId,
      title,
      description,
    });

    await newTask.save();

    res.status(201).json({ message: "Task created successfully", task: newTask });
  } 
  catch (error) {
    res.status(500).json({ message: "Error creating task", error: error.message });
  }
};

exports.getTasks = async (req, res) => {
  try {
    const userId = req.query.userId;
    
    if (!userId) {
      return res.status(400).json({ message: "userId is required in query params" });
    }

    const tasks = await Task.find({ userId }).sort({ createdAt: -1 });

    res.status(200).json({ tasks });
  } 
  catch (error) {
    res.status(500).json({ message: "Error fetching tasks", error: error.message });
  }

};

exports.updateTask = async (req, res) => {
  try {
    const { taskId, title, description, status, userId } = req.body;

    const task = await Task.findOne({ _id: taskId, userId });
    if (!task) {
      return res.status(404).json({ message: "Task not found" });
    }

    if (title !== undefined) task.title = title;
    if (description !== undefined) task.description = description;
    if (status !== undefined) task.status = status;

    await task.save();

    res.status(200).json({ message: "Task updated succesfully", task });
  }
  catch (error) {
    res.status(500).json({ message: "Failed updating task", error: error.message });
  }

};
